package sonido_vivo_backend.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import sonido_vivo_backend.model.Boleta;
import java.util.List;

@Repository
public interface BoletaRepository extends JpaRepository<Boleta, Long> {
    List<Boleta> findByUsuarioIdOrderByFechaDesc(Long usuarioId);
}