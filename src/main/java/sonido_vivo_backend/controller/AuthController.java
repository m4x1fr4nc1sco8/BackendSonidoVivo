package sonido_vivo_backend.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.*;
import sonido_vivo_backend.model.Usuario;
import sonido_vivo_backend.repository.UsuarioRepository;
import sonido_vivo_backend.security.JwtService;

import java.util.HashMap;
import java.util.Map;
import java.util.Optional;

@RestController
@RequestMapping("/api/v1/auth")
@CrossOrigin(origins = "*")
public class AuthController {

    @Autowired
    private UsuarioRepository usuarioRepository;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Autowired
    private JwtService jwtService;

    @PostMapping("/registro")
    public ResponseEntity<?> registrar(@RequestBody Usuario usuario) {
        if (usuarioRepository.findByEmail(usuario.getEmail()).isPresent()) {
            return ResponseEntity.badRequest().body(Map.of("error", "El correo ya está registrado"));
        }
        usuario.setPassword(passwordEncoder.encode(usuario.getPassword()));
        if (usuario.getRol() == null || usuario.getRol().isEmpty()) {
            usuario.setRol("ROLE_CLIENTE");
        }
        Usuario guardado = usuarioRepository.save(usuario);
        return ResponseEntity.ok(Map.of(
                "mensaje", "Usuario registrado exitosamente",
                "id", guardado.getId(),
                "email", guardado.getEmail(),
                "rol", guardado.getRol()
        ));
    }

    @PostMapping("/login")
    public ResponseEntity<?> login(@RequestBody Map<String, String> credenciales) {
        String email = credenciales.get("email");
        String password = credenciales.get("password");

        Optional<Usuario> userOpt = usuarioRepository.findByEmail(email);

        if (userOpt.isPresent()) {
            Usuario user = userOpt.get();
            // Valida contraseña encriptada (BCrypt) o texto plano de prueba inicial
            boolean passwordValida = passwordEncoder.matches(password, user.getPassword())
                    || password.equals(user.getPassword());

            if (passwordValida) {
                String token = jwtService.generarToken(user.getEmail(), user.getRol());
                Map<String, Object> respuesta = new HashMap<>();
                respuesta.put("token", token);
                respuesta.put("id", user.getId());
                respuesta.put("nombre", user.getNombre());
                respuesta.put("email", user.getEmail());
                respuesta.put("rol", user.getRol());
                return ResponseEntity.ok(respuesta);
            }
        }

        return ResponseEntity.status(401).body(Map.of("error", "Credenciales inválidas"));
    }
}