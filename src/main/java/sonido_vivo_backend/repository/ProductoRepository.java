package sonido_vivo_backend.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import sonido_vivo_backend.model.Producto;

public interface ProductoRepository extends JpaRepository<Producto, Long> {
}