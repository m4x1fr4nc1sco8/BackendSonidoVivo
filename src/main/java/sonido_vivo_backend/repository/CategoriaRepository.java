package sonido_vivo_backend.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import sonido_vivo_backend.model.Categoria;

public interface CategoriaRepository extends JpaRepository<Categoria, Long> {
}