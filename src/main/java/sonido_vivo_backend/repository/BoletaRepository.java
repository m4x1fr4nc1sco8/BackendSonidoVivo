package sonido_vivo_backend.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import sonido_vivo_backend.model.Boleta;

public interface BoletaRepository extends JpaRepository<Boleta, Long> {
}