package sonido_vivo_backend.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
import org.springframework.web.cors.CorsConfiguration;

import java.util.List;

@Configuration
@EnableWebSecurity
public class SecurityConfig {

    @Autowired
    private JwtFilter jwtFilter;

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        http
            .csrf(csrf -> csrf.disable())
            .cors(cors -> cors.configurationSource(request -> {
                CorsConfiguration config = new CorsConfiguration();
                config.setAllowedOrigins(List.of("*"));
                config.setAllowedMethods(List.of("GET", "POST", "PUT", "PATCH", "DELETE", "OPTIONS"));
                config.setAllowedHeaders(List.of("*"));
                return config;
            }))
            .sessionManagement(session -> session.sessionCreationPolicy(SessionCreationPolicy.STATELESS))
            .authorizeHttpRequests(auth -> auth
                // Rutas públicas: Login, Registro, Swagger y ver catálogo
                .requestMatchers("/api/v1/auth/**").permitAll()
                .requestMatchers("/swagger-ui/**", "/swagger-ui.html", "/v3/api-docs/**").permitAll()
                .requestMatchers(HttpMethod.GET, "/api/v1/productos/**", "/api/v1/categorias/**").permitAll()

                // Gestión de productos y categorías: Solo ADMINISTRADOR
                .requestMatchers(HttpMethod.POST, "/api/v1/productos/**", "/api/v1/categorias/**").hasAuthority("ROLE_ADMINISTRADOR")
                .requestMatchers(HttpMethod.PUT, "/api/v1/productos/**").hasAuthority("ROLE_ADMINISTRADOR")
                .requestMatchers(HttpMethod.PATCH, "/api/v1/productos/**").hasAuthority("ROLE_ADMINISTRADOR")
                .requestMatchers(HttpMethod.DELETE, "/api/v1/productos/**").hasAuthority("ROLE_ADMINISTRADOR")

                // Historial del propio cliente (cualquier usuario autenticado)
                .requestMatchers(HttpMethod.GET, "/api/v1/boletas/usuario/**").authenticated()

                // Órdenes / Boletas: Ver y actualizar estado (Admin y Vendedor), Eliminar (Solo Admin), Comprar (Autenticado)
                .requestMatchers(HttpMethod.GET, "/api/v1/boletas/**").hasAnyAuthority("ROLE_ADMINISTRADOR", "ROLE_VENDEDOR")
                .requestMatchers(HttpMethod.PATCH, "/api/v1/boletas/**").hasAnyAuthority("ROLE_ADMINISTRADOR", "ROLE_VENDEDOR")
                .requestMatchers(HttpMethod.DELETE, "/api/v1/boletas/**").hasAuthority("ROLE_ADMINISTRADOR")
                .requestMatchers(HttpMethod.POST, "/api/v1/boletas/**").authenticated()

                .anyRequest().authenticated()
            )
            .addFilterBefore(jwtFilter, UsernamePasswordAuthenticationFilter.class);

        return http.build();
    }
}