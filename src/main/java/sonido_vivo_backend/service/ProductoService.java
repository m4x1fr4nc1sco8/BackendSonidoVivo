package sonido_vivo_backend.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import sonido_vivo_backend.model.Producto;
import sonido_vivo_backend.repository.ProductoRepository;
import java.util.List;

@Service
public class ProductoService {

    @Autowired
    private ProductoRepository productoRepository;

    public List<Producto> listarTodos() {
        return productoRepository.findAll();
    }

    public Producto obtenerPorId(Long id) {
        return productoRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Producto no encontrado"));
    }

    public Producto crear(Producto producto) {
        return productoRepository.save(producto);
    }

    public Producto actualizar(Long id, Producto detalles) {
        Producto producto = obtenerPorId(id);
        producto.setNombre(detalles.getNombre());
        producto.setCategoria(detalles.getCategoria());
        producto.setPrecio(detalles.getPrecio());
        producto.setStock(detalles.getStock());
        producto.setImagenUrl(detalles.getImagenUrl());
        return productoRepository.save(producto);
    }

    public Producto sumarStock(Long id, int cantidad) {
        Producto producto = obtenerPorId(id);
        producto.setStock(producto.getStock() + cantidad);
        return productoRepository.save(producto);
    }

    public void eliminar(Long id) {
        productoRepository.deleteById(id);
    }
}