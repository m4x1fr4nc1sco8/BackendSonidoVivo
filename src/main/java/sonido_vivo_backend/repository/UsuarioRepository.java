package sonido_vivo_backend.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import sonido_vivo_backend.model.Usuario;
import java.util.Optional;

public interface UsuarioRepository extends JpaRepository<Usuario, Long> {
    Optional<Usuario> findByEmail(String email);
}