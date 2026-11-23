-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 23-11-2026 a las 20:16:22
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `sonido_vivo_db`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `boletas`
--

CREATE TABLE `boletas` (
  `id` bigint(20) NOT NULL,
  `usuario_id` bigint(20) NOT NULL,
  `fecha` datetime NOT NULL DEFAULT current_timestamp(),
  `total` double NOT NULL,
  `estado` varchar(255) NOT NULL,
  `direccion` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `boletas`
--

INSERT INTO `boletas` (`id`, `usuario_id`, `fecha`, `total`, `estado`, `direccion`) VALUES
(1, 3, '2026-11-12 23:00:45', 129990, 'PENDIENTE', 'horcone'),
(2, 3, '2026-11-15 22:46:00', 89990, 'CANCELADO', 'jpfodasda');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categorias`
--

CREATE TABLE `categorias` (
  `id` bigint(20) NOT NULL,
  `nombre` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `categorias`
--

INSERT INTO `categorias` (`id`, `nombre`) VALUES
(9, 'Accesorios'),
(6, 'Amplificadores'),
(3, 'Bajos Eléctricos'),
(4, 'Baterías'),
(10, 'Estudio y Grabación'),
(1, 'Guitarras Acústicas'),
(2, 'Guitarras Eléctricas'),
(7, 'Micrófonos'),
(8, 'Pedales de Efectos'),
(5, 'Teclados y Pianos');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_boleta`
--

CREATE TABLE `detalle_boleta` (
  `id` bigint(20) NOT NULL,
  `boleta_id` bigint(20) NOT NULL,
  `producto_id` bigint(20) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `precio_unitario` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `detalle_boleta`
--

INSERT INTO `detalle_boleta` (`id`, `boleta_id`, `producto_id`, `cantidad`, `precio_unitario`) VALUES
(1, 1, 1, 1, 129990),
(2, 2, 3, 1, 89990);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos`
--

CREATE TABLE `productos` (
  `id` bigint(20) NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `categoria_id` bigint(20) NOT NULL,
  `precio` double NOT NULL,
  `stock` int(11) NOT NULL,
  `imagen_url` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `productos`
--

INSERT INTO `productos` (`id`, `nombre`, `categoria_id`, `precio`, `stock`, `imagen_url`) VALUES
(1, 'Guitarra Acústica Folk Yamaha F310', 1, 129990, 7, 'https://http2.mlstatic.com/D_NQ_NP_2X_922300-MLC89594324038_082025-F-guitarra-acustica-tipo-folk-yamaha-f310.webp'),
(2, 'Guitarra Acústica Dreadnought Fender CD-60S', 1, 189990, 5, 'https://images-na.ssl-images-amazon.com/images/I/7198WAkPuUL.jpg'),
(3, 'Guitarra Acústica Clásica 4/4 Yamaha C40', 1, 89990, 10, 'https://http2.mlstatic.com/D_NQ_NP_2X_948126-MLU78686308731_082024-F.webp'),
(4, 'Guitarra Electroacústica Takamine GN20CE', 1, 349990, 3, 'https://rdmusico.cl/cdn/shop/files/180934-1200-auto.webp?v=1755969817'),
(5, 'Guitarra 3/4 Niños Yamaha JR1', 1, 79990, 6, 'https://r2.gear4music.com/media/71/713658/600/preview.jpg'),
(6, 'Guitarra Eléctrica Stratocaster Squier Affinity Strat', 2, 249990, 5, 'https://audiomusicacl.vtexassets.com/arquivos/ids/191373-1200-auto?v=638525238272970000&width=1200&height=auto&aspect=true'),
(7, 'Guitarra Eléctrica Les Paul Epiphone Les Paul Std', 2, 329990, 4, 'https://media.spdigital.cl/thumbnails/products/n54dmcp4_386c6323_thumbnail_512.png'),
(8, 'Guitarra Eléctrica SG Epiphone SG Standard', 2, 319990, 3, 'https://cl-cenco-pim-resizer.ecomm.cencosud.com/unsafe/adaptive-fit-in/3840x0/filters:quality(75)/prd-cl/product-medias/3908b463-ba9d-4c18-b688-144fa7c5408e/MK9D1X6DYX/MK9D1X6DYX-1/1712677098490-MK9D1X6DYX-1-0.jpg'),
(9, 'Guitarra Eléctrica Telecaster Squier Classic Vibe 50s', 2, 399990, 2, 'https://audiomusicacl.vtexassets.com/arquivos/ids/208813-1200-auto?v=639088534130300000&width=1200&height=auto&aspect=true'),
(10, 'Guitarra Eléctrica RG Ibanez GRG121DX', 2, 219990, 6, 'https://media.spdigital.cl/thumbnails/products/pa6nvdd7_4a9bf8a0_thumbnail_512.jpg'),
(11, 'Bajo Eléctrico 4 Cuerdas Ibanez GSR200', 3, 259990, 4, 'https://i5.walmartimages.cl/asr/e1169ad8-53f8-4997-8925-116a3bf4f534.3232330ff5fe3ef9d3837b3c1c115db8.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF'),
(12, 'Bajo Eléctrico Jazz Bass Squier Affinity JB', 3, 289990, 3, 'https://lacasadelmusico.cl/wp-content/uploads/2022/10/1644360192_0918.jpg'),
(13, 'Bajo Eléctrico 5 Cuerdas Yamaha TRBX305', 3, 389990, 2, 'https://cdnx.jumpseller.com/instruments/image/70527976/thumb/1440/1440?1765304502'),
(14, 'Bajo Eléctrico Precision Bass Squier Classic Vibe 60s PB', 3, 419990, 2, 'https://audiomusicacl.vtexassets.com/arquivos/ids/197179-1200-auto?v=638726506944030000&width=1200&height=auto&aspect=true'),
(15, 'Bajo Activo 4 Cuerdas Cort Action Bass Plus', 3, 199990, 5, 'https://rgstore.cl/cdn/shop/files/rgmusic_img_2025_prod_001-600x600.webp?v=1772197720'),
(16, 'Batería Acústica 5 Piezas Pearl Export EXX725', 4, 649990, 2, 'https://arthurmusic.cl/cdn/shop/files/Export_20EXX725SPC21.jpg?v=1776881607&width=3840'),
(17, 'Batería Electrónica Roland TD-02KV', 4, 499990, 3, 'https://audiomusicacl.vtexassets.com/arquivos/ids/208391-1200-auto?v=639069303453000000&width=1200&height=auto&aspect=true'),
(18, 'Batería Electrónica Alesis Nitro Max Kit', 4, 389990, 4, 'https://cl-cenco-pim-resizer.ecomm.cencosud.com/unsafe/adaptive-fit-in/640x0/filters:quality(75)/prd-cl/product-medias/041e5141-f5f1-4a95-9b26-8897b370c22e/MKEU8Z70BT/MKEU8Z70BT-1/1734377898863-MKEU8Z70BT-1-1.jpg'),
(19, 'Batería Acústica Infantil Mapex Comet Series', 4, 329990, 3, 'https://cdnx.jumpseller.com/sagas-music-shop/image/69303621/resize/1438/1438?1762203636'),
(20, 'Cajón Peruano Flamenquero Meinl HCAJ1NT', 4, 79990, 7, 'https://gamamusic.com/cdn/shop/files/HCAJ1NT-2.webp?v=1779468075&width=800'),
(21, 'Teclado Sensitivo 61 Teclas Yamaha PSR-E373', 5, 229990, 5, 'https://http2.mlstatic.com/D_NQ_NP_2X_901874-MLU72757256298_112023-F.webp'),
(22, 'Piano Digital 88 Teclas Pesadas Casio CDP-S110', 5, 429990, 3, 'https://cdnx.jumpseller.com/mercurymusic/image/63154461/resize/540/540?1746481817'),
(23, 'Sintetizador Analógico Korg Minilogue XD', 5, 589990, 2, 'https://cdnx.jumpseller.com/mpro-import/image/29379402/resize/570/765?1668138999'),
(24, 'Teclado Controlador MIDI Nektar Impact GX61', 5, 119990, 6, 'https://http2.mlstatic.com/D_NQ_NP_2X_669918-MLC72569001876_112023-F-nektar-impact-gx61--controlador-midi.webp'),
(25, 'Piano Digital de Escenario Roland FP-10', 5, 499990, 2, 'https://cdnx.jumpseller.com/instruments/image/76512380/thumb/1440/1440?1778531051'),
(26, 'Amplificador de Guitarra 15W Fender Mustang LT25', 6, 159990, 5, 'https://http2.mlstatic.com/D_NQ_NP_2X_734452-CBT111696180005_052026-F.webp'),
(27, 'Amplificador de Guitarra 50W Boss Katana 50 MKII', 6, 279990, 4, 'https://http2.mlstatic.com/D_NQ_NP_2X_782627-MLU72829940371_112023-F.webp'),
(28, 'Amplificador de Bajo 25W Fender Rumble 25', 6, 139990, 6, 'https://www.fender.cl/media/catalog/product/cache/1/image/265x265/9df78eab33525d08d6e5fb8d27136e95/a/b/ab051_2370200000v2.jpg'),
(29, 'Amplificador a Tubos 15W Vox AC15C1', 6, 689990, 2, 'https://cdnx.jumpseller.com/instruments/image/73821460/thumb/1440/1440?1778188391'),
(30, 'Amplificador de Guitarra 10W Marshall MG10 Gold', 6, 89999, 8, 'https://cdnx.jumpseller.com/instruments/image/43059949/thumb/1440/1391?1701560869'),
(31, 'Micrófono Dinámico Vocal Shure SM58', 7, 119990, 12, 'https://promusic.cl/cdn/shop/files/SM58_3_a99a39d8-1752-410f-8dec-cf7e192ed935.jpg?v=1767620327&width=2000'),
(32, 'Micrófono de Condensador Audio-Technica AT2020', 7, 99990, 8, 'https://b2811249.assetcdn.net/2811249/wp-content/uploads/2020/10/AT1-400x400.jpg?lossy=1&strip=1&webp=1'),
(33, 'Micrófono Dinámico de Instrumento Shure SM57', 7, 109990, 10, 'https://www.feedbackmusic.cl/wp-content/uploads/2025/09/SM57LC.png'),
(34, 'Micrófono USB para Streaming HyperX SoloCast', 7, 49990, 15, 'https://media.falabella.com/falabellaCL/146040963_01/w=1200,h=1200,fit=pad'),
(35, 'Micrófono de Condensador AKG P120', 7, 89990, 6, 'https://i5.walmartimages.cl/asr/b06fbb70-2b37-4c42-a8c1-4be2b0be3b55.e4115117fd8a963bb50b06b62e9c6a67.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF'),
(36, 'Pedal Overdrive Boss SD-1 Super Overdrive', 8, 69990, 9, 'https://cl-cenco-pim-resizer.ecomm.cencosud.com/unsafe/adaptive-fit-in/640x0/filters:quality(75)/prd-cl/product-medias/7735d94e-be1b-4eb9-8eaf-c543e9a9b488/MK7DE7ORY7/MK7DE7ORY7-1/1751470574243-MK7DE7ORY7-1-1.jpg'),
(37, 'Pedal Delay Electro-Harmonix Canyon Delay', 8, 149990, 4, 'https://cdnx.jumpseller.com/musicchile/image/57540294/thumb/1600/1600?1759327126'),
(38, 'Pedal Tuner/Afinador TC Electronic PolyTune 3', 8, 89990, 7, 'https://www.planetmusic.cl/wp-content/uploads/2024/06/TC-Electronic-Polytune-3-Mini-Pedal-Afinador-y-Buffer-de-Guitarra-R-Planet-Music-1200x1200-1-600x600.jpg'),
(39, 'Pedal Distorsión ProCo Rat 2', 8, 99990, 5, 'https://armonicos.cl/4179-thickbox_default/proco-rat-2.jpg'),
(40, 'Pedal Multi-Efectos Zoom G1 Four', 8, 79990, 10, 'https://musicstore.cl/9140-thickbox_default/multiefecto-zoom-g1-four.jpg'),
(41, 'Afinador Cromático de Clip Korg Pitchclip 2', 9, 12999, 25, 'https://audiomusicacl.vtexassets.com/arquivos/ids/180222-1200-auto?v=638011505859270000&width=1200&height=auto&aspect=true'),
(42, 'Encordado Guitarra Eléctrica 0.10 D\'Addario EXL110', 9, 8990, 40, 'https://cdnx.jumpseller.com/musicchile/image/57537872/thumb/1600/1600?1760990174'),
(43, 'Soporte Universal de Guitarra Hercules GS414B PLUS', 9, 34990, 12, 'https://audiomusicacl.vtexassets.com/arquivos/ids/206890-1200-auto?v=639039995551870000&width=1200&height=auto&aspect=true'),
(44, 'Cable de Instrumento 3m Fender Deluxe Cable', 9, 17990, 20, 'https://http2.mlstatic.com/D_NQ_NP_2X_904956-MLC86361863747_062025-F.webp'),
(45, 'Funda Acolchada Guitarra Eléctrica Ritter RGP2-E', 9, 29990, 15, 'https://audiomusicacl.vtexassets.com/arquivos/ids/194419-1200-auto?v=638615180054300000&width=1200&height=auto&aspect=true'),
(46, 'Interfaz de Audio USB Focusrite Scarlett 2i2 4th Gen', 10, 199990, 6, 'https://http2.mlstatic.com/D_NQ_NP_2X_730789-MLA100048520427_122025-F.webp'),
(47, 'Monitores de Estudio Activos (Par) M-Audio BX5 D3', 10, 229990, 4, 'https://cdnx.jumpseller.com/sonidos-portenos/image/76331645/thumb/719/719?1778001021'),
(48, 'Audífonos de Monitoreo Audio-Technica ATH-M40x', 10, 109990, 8, 'https://cdnx.jumpseller.com/instruments/image/69087526/thumb/1440/1440?1761523626'),
(49, 'Consola de Mezcla 6 Canales Yamaha MG06X', 10, 149990, 3, 'https://promusic.cl/cdn/shop/files/MG06X-1.png?v=1753220131&width=2000'),
(50, 'Controlador MIDI de Pads AKAI LPD8 MK2', 10, 59990, 10, 'https://b2811249.assetcdn.net/2811249/wp-content/uploads/2023/04/LPD8_II_RGB_angle_right_web-400x400.jpg?lossy=1&strip=1&webp=1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id` bigint(20) NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `rol` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id`, `nombre`, `email`, `password`, `rol`) VALUES
(1, 'Administrador Sonido Vivo', 'admin@sonidovivo.cl', 'admin123', 'ROLE_ADMINISTRADOR'),
(2, 'Vendedor Tienda', 'vendedor@sonidovivo.cl', 'vendedor123', 'ROLE_VENDEDOR'),
(3, 'Carlos Muñoz', 'cliente@sonidovivo.cl', 'cliente123', 'ROLE_CLIENTE');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `boletas`
--
ALTER TABLE `boletas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `usuario_id` (`usuario_id`);

--
-- Indices de la tabla `categorias`
--
ALTER TABLE `categorias`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nombre` (`nombre`);

--
-- Indices de la tabla `detalle_boleta`
--
ALTER TABLE `detalle_boleta`
  ADD PRIMARY KEY (`id`),
  ADD KEY `boleta_id` (`boleta_id`),
  ADD KEY `producto_id` (`producto_id`);

--
-- Indices de la tabla `productos`
--
ALTER TABLE `productos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `categoria_id` (`categoria_id`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `boletas`
--
ALTER TABLE `boletas`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `categorias`
--
ALTER TABLE `categorias`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `detalle_boleta`
--
ALTER TABLE `detalle_boleta`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `productos`
--
ALTER TABLE `productos`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=51;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `boletas`
--
ALTER TABLE `boletas`
  ADD CONSTRAINT `boletas_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`);

--
-- Filtros para la tabla `detalle_boleta`
--
ALTER TABLE `detalle_boleta`
  ADD CONSTRAINT `detalle_boleta_ibfk_1` FOREIGN KEY (`boleta_id`) REFERENCES `boletas` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `detalle_boleta_ibfk_2` FOREIGN KEY (`producto_id`) REFERENCES `productos` (`id`);

--
-- Filtros para la tabla `productos`
--
ALTER TABLE `productos`
  ADD CONSTRAINT `productos_ibfk_1` FOREIGN KEY (`categoria_id`) REFERENCES `categorias` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
