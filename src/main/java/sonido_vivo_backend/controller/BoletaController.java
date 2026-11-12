package sonido_vivo_backend.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import sonido_vivo_backend.model.Boleta;
import sonido_vivo_backend.service.BoletaService;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/v1/boletas")
@CrossOrigin(origins = "*")
public class BoletaController {

    @Autowired
    private BoletaService boletaService;

    @GetMapping
    public ResponseEntity<List<Boleta>> listar() {
        return ResponseEntity.ok(boletaService.listarTodas());
    }

    @PostMapping
    public ResponseEntity<Boleta> crear(@RequestBody Boleta boleta) {
        return ResponseEntity.ok(boletaService.crearBoleta(boleta));
    }

    @PatchMapping("/{id}/estado")
    public ResponseEntity<Boleta> cambiarEstado(@PathVariable Long id, @RequestBody Map<String, String> body) {
        return ResponseEntity.ok(boletaService.actualizarEstado(id, body.get("estado")));
    }
}