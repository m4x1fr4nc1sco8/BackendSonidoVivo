package sonido_vivo_backend.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import sonido_vivo_backend.model.Boleta;
import sonido_vivo_backend.model.DetalleBoleta;
import sonido_vivo_backend.model.Producto;
import sonido_vivo_backend.repository.BoletaRepository;
import sonido_vivo_backend.repository.ProductoRepository;
import java.time.LocalDateTime;
import java.util.List;

@Service
public class BoletaService {

    @Autowired
    private BoletaRepository boletaRepository;

    @Autowired
    private ProductoRepository productoRepository;

    public List<Boleta> listarTodas() {
        return boletaRepository.findAll();
    }

    public List<Boleta> listarPorUsuario(Long usuarioId) {
        return boletaRepository.findByUsuarioIdOrderByFechaDesc(usuarioId);
    }

    @Transactional
    public Boleta crearBoleta(Boleta boleta) {
        boleta.setFecha(LocalDateTime.now());
        if (boleta.getEstado() == null) {
            boleta.setEstado("PENDIENTE");
        }

        double totalCalculado = 0.0;

        if (boleta.getDetalles() != null) {
            for (DetalleBoleta detalle : boleta.getDetalles()) {
                Producto prod = productoRepository.findById(detalle.getProducto().getId())
                        .orElseThrow(() -> new RuntimeException("Producto no encontrado"));

                if (prod.getStock() < detalle.getCantidad()) {
                    throw new RuntimeException("Stock insuficiente para: " + prod.getNombre());
                }

                // Descontar stock automáticamente
                prod.setStock(prod.getStock() - detalle.getCantidad());
                productoRepository.save(prod);

                // Asignar relación y precio real
                detalle.setBoleta(boleta);
                detalle.setPrecioUnitario(prod.getPrecio());
                totalCalculado += prod.getPrecio() * detalle.getCantidad();
            }
        }

        boleta.setTotal(totalCalculado);
        return boletaRepository.save(boleta);
    }

    @Transactional
    public Boleta actualizarEstado(Long id, String nuevoEstado) {
        Boleta boleta = boletaRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Boleta no encontrada"));

        // Si se cancela por primera vez, devolver stock a MySQL
        if ("CANCELADO".equalsIgnoreCase(nuevoEstado) && !"CANCELADO".equalsIgnoreCase(boleta.getEstado())) {
            devolverStock(boleta);
        }

        boleta.setEstado(nuevoEstado);
        return boletaRepository.save(boleta);
    }

    @Transactional
    public void eliminarBoleta(Long id) {
        Boleta boleta = boletaRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Boleta no encontrada"));

        if (!"CANCELADO".equalsIgnoreCase(boleta.getEstado())) {
            devolverStock(boleta);
        }

        boletaRepository.delete(boleta);
    }

    private void devolverStock(Boleta boleta) {
        if (boleta.getDetalles() != null) {
            for (DetalleBoleta detalle : boleta.getDetalles()) {
                Producto prod = productoRepository.findById(detalle.getProducto().getId()).orElse(null);
                if (prod != null) {
                    prod.setStock(prod.getStock() + detalle.getCantidad());
                    productoRepository.save(prod);
                }
            }
        }
    }
}