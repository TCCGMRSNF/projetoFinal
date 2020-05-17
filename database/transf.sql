-- --------------------------------------------------------
-- Servidor:                     mysql669.umbler.com
-- Versão do servidor:           5.6.40 - MySQL Community Server (GPL)
-- OS do Servidor:               Linux
-- HeidiSQL Versão:              11.0.0.5919
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- Copiando estrutura para tabela kaizuka.evento-quesito
CREATE TABLE IF NOT EXISTS `evento-quesito` (
  `evt_id` int(11) NOT NULL,
  `qst_id` int(11) NOT NULL,
  `peso` decimal(6,3) unsigned NOT NULL DEFAULT '1.000',
  `ts_new` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ts_upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`qst_id`,`evt_id`),
  KEY `FK_evento_quesito_eventos` (`evt_id`),
  CONSTRAINT `FK_evento_quesito_eventos` FOREIGN KEY (`evt_id`) REFERENCES `eventos` (`id`),
  CONSTRAINT `FK_evento_quesito_quesitos` FOREIGN KEY (`qst_id`) REFERENCES `quesitos` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Quesitos de avaliação de cada evento';

-- Copiando dados para a tabela kaizuka.evento-quesito: ~3 rows (aproximadamente)
/*!40000 ALTER TABLE `evento-quesito` DISABLE KEYS */;
INSERT INTO `evento-quesito` (`evt_id`, `qst_id`, `peso`, `ts_new`, `ts_upd`) VALUES
	(1, 1, 1.000, '2020-04-21 13:35:46', '2020-04-21 15:10:46'),
	(1, 2, 2.000, '2020-04-21 20:11:39', '2020-04-21 20:11:39'),
	(1, 3, 2.000, '2020-04-21 20:11:55', '2020-04-21 20:11:55');
/*!40000 ALTER TABLE `evento-quesito` ENABLE KEYS */;

-- Copiando estrutura para tabela kaizuka.evento-usuario
CREATE TABLE IF NOT EXISTS `evento-usuario` (
  `evt_id` int(11) NOT NULL,
  `usr_id` int(11) NOT NULL,
  `funcao` enum('0','1','2') NOT NULL DEFAULT '2',
  `ts_new` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ts_upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  UNIQUE KEY `Index 3` (`evt_id`,`usr_id`,`funcao`),
  KEY `FK_evento_usuario_usuarios` (`usr_id`),
  CONSTRAINT `FK_evento_usuario_eventos` FOREIGN KEY (`evt_id`) REFERENCES `eventos` (`id`),
  CONSTRAINT `FK_evento_usuario_usuarios` FOREIGN KEY (`usr_id`) REFERENCES `usuarios` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Copiando dados para a tabela kaizuka.evento-usuario: ~3 rows (aproximadamente)
/*!40000 ALTER TABLE `evento-usuario` DISABLE KEYS */;
INSERT INTO `evento-usuario` (`evt_id`, `usr_id`, `funcao`, `ts_new`, `ts_upd`) VALUES
	(1, 1, '0', '2020-04-19 21:59:19', '2020-04-19 21:59:19'),
	(1, 2, '1', '2020-04-19 21:59:52', '2020-04-19 21:59:52'),
	(1, 3, '2', '2020-04-19 22:00:24', '2020-04-19 22:00:24');
/*!40000 ALTER TABLE `evento-usuario` ENABLE KEYS */;

-- Copiando estrutura para tabela kaizuka.eventos
CREATE TABLE IF NOT EXISTS `eventos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `owner` int(11) NOT NULL,
  `descricao` varchar(50) NOT NULL DEFAULT '',
  `resumo` varchar(200) NOT NULL DEFAULT '',
  `qtd_cand` int(10) unsigned NOT NULL DEFAULT '0',
  `qtd_aprov` int(10) unsigned NOT NULL DEFAULT '0',
  `ts_ini` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ts_fim` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `nota_min` decimal(25,15) unsigned NOT NULL DEFAULT '0.000000000000000',
  `nota_max` decimal(25,15) unsigned NOT NULL DEFAULT '0.000000000000000',
  `nota_decimais` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `score_decimais` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `editar` enum('Y','N') NOT NULL DEFAULT 'N',
  `votar` enum('Y','N') NOT NULL DEFAULT 'N',
  `ts_new` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ts_upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `FK_eventos_usuarios` (`owner`),
  CONSTRAINT `FK_eventos_usuarios` FOREIGN KEY (`owner`) REFERENCES `usuarios` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

-- Copiando dados para a tabela kaizuka.eventos: ~1 rows (aproximadamente)
/*!40000 ALTER TABLE `eventos` DISABLE KEYS */;
INSERT INTO `eventos` (`id`, `owner`, `descricao`, `resumo`, `qtd_cand`, `qtd_aprov`, `ts_ini`, `ts_fim`, `nota_min`, `nota_max`, `nota_decimais`, `score_decimais`, `editar`, `votar`, `ts_new`, `ts_upd`) VALUES
	(1, 19, 'SELEÇÃO BAILARINOS CIA MUNICIPAL DE', '', 0, 0, '2020-04-25 09:00:00', '2020-04-25 16:00:00', 0.000000000000000, 0.000000000000000, 2, 3, '', '', '2020-04-19 21:53:50', '2020-05-12 19:55:19');
/*!40000 ALTER TABLE `eventos` ENABLE KEYS */;

-- Copiando estrutura para tabela kaizuka.links
CREATE TABLE IF NOT EXISTS `links` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(150) NOT NULL,
  `url` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `usr_id` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `FK_links_usuarios` (`usr_id`),
  CONSTRAINT `FK_links_usuarios` FOREIGN KEY (`usr_id`) REFERENCES `usuarios` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=latin1;

-- Copiando dados para a tabela kaizuka.links: ~10 rows (aproximadamente)
/*!40000 ALTER TABLE `links` DISABLE KEYS */;
INSERT INTO `links` (`id`, `title`, `url`, `description`, `usr_id`, `created_at`) VALUES
	(14, 'Sony', 'http://sony.com', 'PS4\'s House', 19, '2020-04-30 20:48:39'),
	(18, 'Oloko', 'https://gshow.globo.com/programas/domingao-do-faustao/', 'Essa fera aí meu', 20, '2020-04-30 20:57:58'),
	(19, 'Ultrage!', 'https://www.youtube.com/user/bebadex', 'eu tinha uma galinha ...\r\n', 19, '2020-04-30 20:59:46'),
	(21, 'Quac!', 'http://link.com', 'Sei lá!', 19, '2020-04-30 21:09:36'),
	(22, 'TESTE GRANDE', 'http://www.americanas.com', 'OLOKinho meu..', 20, '2020-04-30 21:19:40'),
	(24, 'Instagram', 'http://instagram.com', 'Photos Super!\r\n\r\n', 20, '2020-05-01 18:42:39'),
	(25, 'EA Games', 'http://ea.com', 'site de jogos', 20, '2020-05-02 21:28:32'),
	(26, 'Link Próprio', 'http://ferrari.com', 'Meu próximo', 19, '2020-05-05 22:57:11'),
	(27, 'Cia Mun Dança', 'http://ciamunicipaldancapoa.com', 'Site Oficial da Cia Municipal de Dança de Porto Alegre / RS', 19, '2020-05-06 22:48:18'),
	(28, 'Cia Mun Dança', 'http://ciamunicipaldancapoa.com', 'Site Oficial da Cia Municipal de Dança de Porto Alegre / RS', 20, '2020-05-06 22:55:17');
/*!40000 ALTER TABLE `links` ENABLE KEYS */;

-- Copiando estrutura para tabela kaizuka.notas
CREATE TABLE IF NOT EXISTS `notas` (
  `evt_id` int(11) NOT NULL,
  `qst_id` int(11) NOT NULL,
  `avl_id` int(11) NOT NULL,
  `cdt_id` int(11) NOT NULL,
  `nota` decimal(25,15) unsigned NOT NULL DEFAULT '0.000000000000000',
  `ts_new` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ts_upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`evt_id`,`avl_id`,`cdt_id`,`qst_id`),
  KEY `FK_notas_evento-quesito` (`evt_id`,`qst_id`),
  CONSTRAINT `FK_notas_evento-quesito` FOREIGN KEY (`evt_id`, `qst_id`) REFERENCES `evento-quesito` (`evt_id`, `qst_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Copiando dados para a tabela kaizuka.notas: ~1 rows (aproximadamente)
/*!40000 ALTER TABLE `notas` DISABLE KEYS */;
INSERT INTO `notas` (`evt_id`, `qst_id`, `avl_id`, `cdt_id`, `nota`, `ts_new`, `ts_upd`) VALUES
	(1, 1, 2, 3, 5.000000000000000, '2020-04-21 20:13:09', '2020-04-21 20:13:09');
/*!40000 ALTER TABLE `notas` ENABLE KEYS */;

-- Copiando estrutura para tabela kaizuka.quesitos
CREATE TABLE IF NOT EXISTS `quesitos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `descricao` char(20) NOT NULL,
  `ts_new` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ts_upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Index 2` (`descricao`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1 COMMENT='Quesitos de avaliação de cada evento';

-- Copiando dados para a tabela kaizuka.quesitos: ~3 rows (aproximadamente)
/*!40000 ALTER TABLE `quesitos` DISABLE KEYS */;
INSERT INTO `quesitos` (`id`, `descricao`, `ts_new`, `ts_upd`) VALUES
	(1, 'AULA', '2020-04-21 13:16:44', '2020-04-21 13:16:44'),
	(2, 'IMPROVISAÇÃO', '2020-04-21 13:16:52', '2020-04-21 13:16:52'),
	(3, 'REPERTÓRIO', '2020-04-21 13:17:11', '2020-04-21 13:17:11');
/*!40000 ALTER TABLE `quesitos` ENABLE KEYS */;

-- Copiando estrutura para tabela kaizuka.resultados
CREATE TABLE IF NOT EXISTS `resultados` (
  `evt_id` int(11) NOT NULL,
  `qst_id` int(11) NOT NULL,
  `cdt_id` int(11) NOT NULL,
  `media` decimal(25,15) unsigned NOT NULL DEFAULT '0.000000000000000',
  `peso` decimal(6,3) unsigned NOT NULL DEFAULT '0.000',
  `score` decimal(25,15) unsigned NOT NULL DEFAULT '0.000000000000000',
  `ts_new` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ts_upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`evt_id`,`qst_id`,`cdt_id`) USING BTREE,
  CONSTRAINT `FK_resultados_evento-quesito` FOREIGN KEY (`evt_id`, `qst_id`) REFERENCES `evento-quesito` (`evt_id`, `qst_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Copiando dados para a tabela kaizuka.resultados: ~3 rows (aproximadamente)
/*!40000 ALTER TABLE `resultados` DISABLE KEYS */;
INSERT INTO `resultados` (`evt_id`, `qst_id`, `cdt_id`, `media`, `peso`, `score`, `ts_new`, `ts_upd`) VALUES
	(1, 1, 1, 8.000000000000000, 1.000, 8.756000000000000, '2020-04-21 17:04:47', '2020-04-21 20:19:37'),
	(1, 2, 1, 8.000000000000000, 2.000, 8.756000000000000, '2020-04-21 20:15:11', '2020-04-21 20:19:44'),
	(1, 3, 1, 9.000000000000000, 2.000, 8.756000000000000, '2020-04-21 20:15:51', '2020-04-21 20:19:54');
/*!40000 ALTER TABLE `resultados` ENABLE KEYS */;

-- Copiando estrutura para tabela kaizuka.sessions
CREATE TABLE IF NOT EXISTS `sessions` (
  `session_id` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `expires` int(11) unsigned NOT NULL,
  `data` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  PRIMARY KEY (`session_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Copiando dados para a tabela kaizuka.sessions: ~146 rows (aproximadamente)
/*!40000 ALTER TABLE `sessions` DISABLE KEYS */;
INSERT INTO `sessions` (`session_id`, `expires`, `data`) VALUES
	('-44-TX5EHQ1ljvPup_WaCW0EL3TrUnpj', 1589676958, '{"cookie":{"originalMaxAge":null,"expires":null,"httpOnly":true,"path":"/"},"flash":{}}'),
	('-si-O5dcstZ0e9RIgFarMC2xIlGOaobN', 1589679359, '{"cookie":{"originalMaxAge":null,"expires":null,"httpOnly":true,"path":"/"},"flash":{}}'),
	('1pW3fBDyPyL_hFq6gesSlFObXrUkKhtM', 1589754358, '{"cookie":{"originalMaxAge":null,"expires":null,"httpOnly":true,"path":"/"},"flash":{}}'),
	('2fD9RFpWPbqoShMbjz2Ck9IC6Dzoq19s', 1589693758, '{"cookie":{"originalMaxAge":null,"expires":null,"httpOnly":true,"path":"/"},"flash":{}}'),
	('2pmHI7Nnnk2vJvbDQW3bEWj0rQjKpMKU', 1589739958, '{"cookie":{"originalMaxAge":null,"expires":null,"httpOnly":true,"path":"/"},"flash":{}}'),
	('31wP0JIJDUdKruu7ocfRF8qJrxBjYDF3', 1589672758, '{"cookie":{"originalMaxAge":null,"expires":null,"httpOnly":true,"path":"/"},"flash":{}}'),
	('3FWLLp6CpcuIiJFdNcPO-oN_xscIB0uI', 1589757360, '{"cookie":{"originalMaxAge":null,"expires":null,"httpOnly":true,"path":"/"},"flash":{}}'),
	('3VDyy-KvxVjKk9P7D0wTyBsHZc9TJexd', 1589694958, '{"cookie":{"originalMaxAge":null,"expires":null,"httpOnly":true,"path":"/"},"flash":{}}'),
	('4iLMYOZzssYmol9iUqeGsDmBkJpl7Sob', 1589691959, '{"cookie":{"originalMaxAge":null,"expires":null,"httpOnly":true,"path":"/"},"flash":{}}'),
	('4qJ_jI9Co2CusWtwDzOqlhX7oKax_QYT', 1589727358, '{"cookie":{"originalMaxAge":null,"expires":null,"httpOnly":true,"path":"/"},"flash":{}}'),
	('5naXWnbq-EEqpSy0CHVu2hWl1vvmigN7', 1589699758, '{"cookie":{"originalMaxAge":null,"expires":null,"httpOnly":true,"path":"/"},"flash":{}}'),
	('5vpTOc7wElkOZiHxWc8MrDiFJpfE32kN', 1589733958, '{"cookie":{"originalMaxAge":null,"expires":null,"httpOnly":true,"path":"/"},"flash":{}}'),
	('68l3cVEKkVzVXGQdeHWz6lAkUy7hxPWq', 1589719558, '{"cookie":{"originalMaxAge":null,"expires":null,"httpOnly":true,"path":"/"},"flash":{}}'),
	('7NYqjVnOnCN6FFixEyBSaQbTEg5X7ui0', 1589726158, '{"cookie":{"originalMaxAge":null,"expires":null,"httpOnly":true,"path":"/"},"flash":{}}'),
	('7qrhmn6tXNOdMHy_fMy0A79ispGKORP2', 1589741158, '{"cookie":{"originalMaxAge":null,"expires":null,"httpOnly":true,"path":"/"},"flash":{}}'),
	('8M0QpOym_6fUWcrE93qNZ_bHis1Mnq0h', 1589721358, '{"cookie":{"originalMaxAge":null,"expires":null,"httpOnly":true,"path":"/"},"flash":{}}'),
	('8Zj2qmZgeovKR8ybSjYI7nhN1tT_1rM1', 1589690158, '{"cookie":{"originalMaxAge":null,"expires":null,"httpOnly":true,"path":"/"},"flash":{}}'),
	('9U5zRuXYRYVGm_k1MqhFdde-u4aD1Ark', 1589732158, '{"cookie":{"originalMaxAge":null,"expires":null,"httpOnly":true,"path":"/"},"flash":{}}'),
	('AE5ycfiMFcBc99GxYjY8lseABViG6OHa', 1589692558, '{"cookie":{"originalMaxAge":null,"expires":null,"httpOnly":true,"path":"/"},"flash":{}}'),
	('AKGseSDjt8Xfw6teSu_KqmQcdDM49Vr5', 1589739358, '{"cookie":{"originalMaxAge":null,"expires":null,"httpOnly":true,"path":"/"},"flash":{}}'),
	('AbYJvn07FoAPkmhxN4QWwEILdJv2SHeC', 1589751958, '{"cookie":{"originalMaxAge":null,"expires":null,"httpOnly":true,"path":"/"},"flash":{}}'),
	('B0ZZMCDuemST8tzlZj5HxkhM-9DyS7rY', 1589714158, '{"cookie":{"originalMaxAge":null,"expires":null,"httpOnly":true,"path":"/"},"flash":{}}'),
	('B0rL40L_WQgIFkD2NXQJhRY1ctGRZKrT', 1589704558, '{"cookie":{"originalMaxAge":null,"expires":null,"httpOnly":true,"path":"/"},"flash":{}}'),
	('Bfv5d97sYr-6FYl3vtXcfCBvSIYFV2wd', 1589676358, '{"cookie":{"originalMaxAge":null,"expires":null,"httpOnly":true,"path":"/"},"flash":{}}'),
	('CQQUpacG9cuwWN5q7Poq8PnfHnyHsuFM', 1589723758, '{"cookie":{"originalMaxAge":null,"expires":null,"httpOnly":true,"path":"/"},"flash":{}}'),
	('CzI3aVsplq2FdcR3NJA4FPUFlh82RttP', 1589712358, '{"cookie":{"originalMaxAge":null,"expires":null,"httpOnly":true,"path":"/"},"flash":{}}'),
	('D6lIIHFZPPHfnuINpePuifmR-RSE4kho', 1589695558, '{"cookie":{"originalMaxAge":null,"expires":null,"httpOnly":true,"path":"/"},"flash":{}}'),
	('DATA2CBc6ZACsUpc4SZq0W7JUVegeuWv', 1589677558, '{"cookie":{"originalMaxAge":null,"expires":null,"httpOnly":true,"path":"/"},"flash":{}}'),
	('DKvRfs-X2jnkggTYFw5kfnQxl2k2kGPR', 1589750158, '{"cookie":{"originalMaxAge":null,"expires":null,"httpOnly":true,"path":"/"},"flash":{}}'),
	('DfD99dkx6JsGFa6oqNtYVcIyNkCvJMCO', 1589675158, '{"cookie":{"originalMaxAge":null,"expires":null,"httpOnly":true,"path":"/"},"flash":{}}'),
	('FluV3MYoRBYU-uDFI5I7YVkcxsU1rrqQ', 1589737558, '{"cookie":{"originalMaxAge":null,"expires":null,"httpOnly":true,"path":"/"},"flash":{}}'),
	('G8n1phng8iqliFZFqiypVlCU4ryi9u2h', 1589687758, '{"cookie":{"originalMaxAge":null,"expires":null,"httpOnly":true,"path":"/"},"flash":{}}'),
	('GccKSgN5Dr6yEL6HJcmIkiGCX6dQzF4D', 1589708158, '{"cookie":{"originalMaxAge":null,"expires":null,"httpOnly":true,"path":"/"},"flash":{}}'),
	('H3LJv7wiloCEnS3XPnYGQgdmVWO_PmIL', 1589674558, '{"cookie":{"originalMaxAge":null,"expires":null,"httpOnly":true,"path":"/"},"flash":{}}'),
	('H_I7EM7xL3QwDEG3HrlncrNY1Kc5LS25', 1589687158, '{"cookie":{"originalMaxAge":null,"expires":null,"httpOnly":true,"path":"/"},"flash":{}}'),
	('HmjPUsjnKioei9YPHgIkDonjjGlafgx1', 1589678158, '{"cookie":{"originalMaxAge":null,"expires":null,"httpOnly":true,"path":"/"},"flash":{}}'),
	('I1aB3hctgPdNIfXMCAtc0CwCD35DU-sL', 1589708758, '{"cookie":{"originalMaxAge":null,"expires":null,"httpOnly":true,"path":"/"},"flash":{}}'),
	('I3Tav8AHzkhvsrE1PHhwLrKbApXGRy88', 1589715358, '{"cookie":{"originalMaxAge":null,"expires":null,"httpOnly":true,"path":"/"},"flash":{}}'),
	('IfHl92xtuipxwYEwudp7qhXoujC_Zw_O', 1589755558, '{"cookie":{"originalMaxAge":null,"expires":null,"httpOnly":true,"path":"/"},"flash":{}}'),
	('JNidI6NPtIBOlTDn3IObjAIYiokSDloP', 1589712958, '{"cookie":{"originalMaxAge":null,"expires":null,"httpOnly":true,"path":"/"},"flash":{}}'),
	('JQLLkD5MVxfhjeKcCh63aMkGZIchyfsW', 1589681158, '{"cookie":{"originalMaxAge":null,"expires":null,"httpOnly":true,"path":"/"},"flash":{}}'),
	('JzqCuYQk9JvhlRpHOoOhSLxlwEhlKlG9', 1589675760, '{"cookie":{"originalMaxAge":null,"expires":null,"httpOnly":true,"path":"/"},"flash":{}}'),
	('K49vu6Ch9n8I869-iq7uQEbAwmmiAnZ1', 1589716558, '{"cookie":{"originalMaxAge":null,"expires":null,"httpOnly":true,"path":"/"},"flash":{}}'),
	('KRXJihNRc4axCJpokngSiTdc5sX-MBcH', 1589688358, '{"cookie":{"originalMaxAge":null,"expires":null,"httpOnly":true,"path":"/"},"flash":{}}'),
	('LH4dIDY061-vKBqipuE_JN_T2zLCCRrV', 1589736958, '{"cookie":{"originalMaxAge":null,"expires":null,"httpOnly":true,"path":"/"},"flash":{}}'),
	('LZa5dW2B2VmpusTe_PZwZgwcmP8Zm8v0', 1589711758, '{"cookie":{"originalMaxAge":null,"expires":null,"httpOnly":true,"path":"/"},"flash":{}}'),
	('Lu0jd3u96ZfjKKYdEpBwR1hYd83fXp5Q', 1589749558, '{"cookie":{"originalMaxAge":null,"expires":null,"httpOnly":true,"path":"/"},"flash":{}}'),
	('MnWUw-ZahicTe7jm1k8iV5vVcaF43qJe', 1589679959, '{"cookie":{"originalMaxAge":null,"expires":null,"httpOnly":true,"path":"/"},"flash":{}}'),
	('NeD0hH3_XLwtulo-UByvFzQ37rNAX66v', 1589701558, '{"cookie":{"originalMaxAge":null,"expires":null,"httpOnly":true,"path":"/"},"flash":{}}'),
	('OMoScPmYjz2awIGrdad2NA2CPhQBFZ0g', 1589756163, '{"cookie":{"originalMaxAge":null,"expires":null,"httpOnly":true,"path":"/"},"flash":{}}'),
	('QVIH9qCv7yAYxVWv9vgjwi8wXH_Q2q-f', 1589720158, '{"cookie":{"originalMaxAge":null,"expires":null,"httpOnly":true,"path":"/"},"flash":{}}'),
	('QggL1z6HuWmGHpn40J_5xbpPLUs9f6PK', 1589702158, '{"cookie":{"originalMaxAge":null,"expires":null,"httpOnly":true,"path":"/"},"flash":{}}'),
	('QtU3kCB4-GxJ1pQiKeJpK3Kq7WEYXIA-', 1589681758, '{"cookie":{"originalMaxAge":null,"expires":null,"httpOnly":true,"path":"/"},"flash":{}}'),
	('QxNnrJqE3M89RG5lrg7fDPgE65Z72Y1r', 1589742958, '{"cookie":{"originalMaxAge":null,"expires":null,"httpOnly":true,"path":"/"},"flash":{}}'),
	('R_KSI_I_Cskx7J0E1EiqYLYI64LNfV42', 1589711158, '{"cookie":{"originalMaxAge":null,"expires":null,"httpOnly":true,"path":"/"},"flash":{}}'),
	('Rqhd5lMawklysh8c8k86UaVNxfe_wRPf', 1589702758, '{"cookie":{"originalMaxAge":null,"expires":null,"httpOnly":true,"path":"/"},"flash":{}}'),
	('SZDwBidwHGPrjk1cwPlDxt-C7A_QFVfG', 1589684158, '{"cookie":{"originalMaxAge":null,"expires":null,"httpOnly":true,"path":"/"},"flash":{}}'),
	('SpdclfFLVqF7F_iawUyk8qLUlP_JPSNr', 1589671558, '{"cookie":{"originalMaxAge":null,"expires":null,"httpOnly":true,"path":"/"},"flash":{}}'),
	('TEoYWOjOewtuv_DqSShGQq0G6St-FAK3', 1589703358, '{"cookie":{"originalMaxAge":null,"expires":null,"httpOnly":true,"path":"/"},"flash":{}}'),
	('TmB1LeB2L2rzeNv-htTAL9-Ns68-RZaD', 1589757958, '{"cookie":{"originalMaxAge":null,"expires":null,"httpOnly":true,"path":"/"},"flash":{}}'),
	('U_vbS8rJfQOT7lhhZJhd4F_cB_kgWHtm', 1589754958, '{"cookie":{"originalMaxAge":null,"expires":null,"httpOnly":true,"path":"/"},"flash":{}}'),
	('Uf6MARvCrCoILj-0o_54mlb1y4iJ7_dE', 1589685358, '{"cookie":{"originalMaxAge":null,"expires":null,"httpOnly":true,"path":"/"},"flash":{}}'),
	('VAMKwNc2NjaGPZjgWKWnyoba1cXCI1Rt', 1589738159, '{"cookie":{"originalMaxAge":null,"expires":null,"httpOnly":true,"path":"/"},"flash":{}}'),
	('VPHR0HJkfGiIFvOAPUyRnGKoFwwAOMqo', 1589721958, '{"cookie":{"originalMaxAge":null,"expires":null,"httpOnly":true,"path":"/"},"flash":{}}'),
	('VUx_M356mUIZhcVtcfMBF7shcJ_mbv52', 1589753758, '{"cookie":{"originalMaxAge":null,"expires":null,"httpOnly":true,"path":"/"},"flash":{}}'),
	('WIYjEYG74hsu9doy_41GtTjj38mFPnI2', 1589723158, '{"cookie":{"originalMaxAge":null,"expires":null,"httpOnly":true,"path":"/"},"flash":{}}'),
	('WPsCPwDAgV-riuFdCv7fT2RCxHkJsOuq', 1589747758, '{"cookie":{"originalMaxAge":null,"expires":null,"httpOnly":true,"path":"/"},"flash":{}}'),
	('WlzvF7cyo4MuMFFSi554Rn4dGR2md2rx', 1589685958, '{"cookie":{"originalMaxAge":null,"expires":null,"httpOnly":true,"path":"/"},"flash":{}}'),
	('Wwdwipnvsp3seaZvIS79aXZzkp6qf182', 1589718360, '{"cookie":{"originalMaxAge":null,"expires":null,"httpOnly":true,"path":"/"},"flash":{}}'),
	('Wxie-VX5qFUZvoHetwkHcKnFbXaFFZRV', 1589735758, '{"cookie":{"originalMaxAge":null,"expires":null,"httpOnly":true,"path":"/"},"flash":{}}'),
	('X147YHlHUbrJY6TfnPb5JTg0d-fwu1Y-', 1589678758, '{"cookie":{"originalMaxAge":null,"expires":null,"httpOnly":true,"path":"/"},"flash":{}}'),
	('XUmSVKyI-Fb6rBr6npYQEbCwl1pnCycT', 1589744160, '{"cookie":{"originalMaxAge":null,"expires":null,"httpOnly":true,"path":"/"},"flash":{}}'),
	('XbGQt03MYrFwfV5zQQheh-7HJLHxz73K', 1589724358, '{"cookie":{"originalMaxAge":null,"expires":null,"httpOnly":true,"path":"/"},"flash":{}}'),
	('XhDEkL8-DgtUXzjoRy4wPNY2KVF-2elG', 1589745958, '{"cookie":{"originalMaxAge":null,"expires":null,"httpOnly":true,"path":"/"},"flash":{}}'),
	('XzNZrNXjstcDhZBqJNnU29HcXQSuOY93', 1589709958, '{"cookie":{"originalMaxAge":null,"expires":null,"httpOnly":true,"path":"/"},"flash":{}}'),
	('Y05BvuKlOW8ZNyyXJtSYxVa8YviQUEy9', 1589751358, '{"cookie":{"originalMaxAge":null,"expires":null,"httpOnly":true,"path":"/"},"flash":{}}'),
	('YVfIr7DxzbYYvkkcZW829qXQXcZXETy3', 1589732758, '{"cookie":{"originalMaxAge":null,"expires":null,"httpOnly":true,"path":"/"},"flash":{}}'),
	('YZEBAkipNRSjsv_b6uyvCDjZsffR1dZ2', 1589750758, '{"cookie":{"originalMaxAge":null,"expires":null,"httpOnly":true,"path":"/"},"flash":{}}'),
	('YqONjqkyU074Rwjd-5razHQze6cwPZ-f', 1589709358, '{"cookie":{"originalMaxAge":null,"expires":null,"httpOnly":true,"path":"/"},"flash":{}}'),
	('YsBb8LY7jU3dgb074BV50JFekFxBspwM', 1589747158, '{"cookie":{"originalMaxAge":null,"expires":null,"httpOnly":true,"path":"/"},"flash":{}}'),
	('ZBc39Cm8nCsmZ_5Dg4HilVxl-tLCpIwR', 1589694358, '{"cookie":{"originalMaxAge":null,"expires":null,"httpOnly":true,"path":"/"},"flash":{}}'),
	('ZWFiYLLnJM6_VQcI__YPrdKOOzFR6JGH', 1589752560, '{"cookie":{"originalMaxAge":null,"expires":null,"httpOnly":true,"path":"/"},"flash":{}}'),
	('ZhPBtbbMcGrz63w9wijzdFImrHQWpfpM', 1589691358, '{"cookie":{"originalMaxAge":null,"expires":null,"httpOnly":true,"path":"/"},"flash":{}}'),
	('ZosfRoYkcS5lqF3-SM-ql71UYpBJXNjm', 1589688958, '{"cookie":{"originalMaxAge":null,"expires":null,"httpOnly":true,"path":"/"},"flash":{}}'),
	('_MrAm2RiNXqCiuXoF3b0hxT7RU_o-XdR', 1589741760, '{"cookie":{"originalMaxAge":null,"expires":null,"httpOnly":true,"path":"/"},"flash":{}}'),
	('a7eqwQUDkFoE1OUPI-scHUEzi4SNpcJv', 1589703958, '{"cookie":{"originalMaxAge":null,"expires":null,"httpOnly":true,"path":"/"},"flash":{}}'),
	('aFHOAmy4yisSl1XmyYECS2MqQxFseYUv', 1589742358, '{"cookie":{"originalMaxAge":null,"expires":null,"httpOnly":true,"path":"/"},"flash":{}}'),
	('aJ8xfry0LQVnDmn1cum0_tr0MRGwZGAB', 1589684760, '{"cookie":{"originalMaxAge":null,"expires":null,"httpOnly":true,"path":"/"},"flash":{}}'),
	('aTFqRzM3ADnkmo2zx6hXy_pgvuaYOH1n', 1589725558, '{"cookie":{"originalMaxAge":null,"expires":null,"httpOnly":true,"path":"/"},"flash":{}}'),
	('agU70NmWs7mQnnv47azwqQOiWNQ19DFe', 1589705158, '{"cookie":{"originalMaxAge":null,"expires":null,"httpOnly":true,"path":"/"},"flash":{}}'),
	('bDLktjBQTT1j8CW4F8mzKGDxXwb9xXM7', 1589693158, '{"cookie":{"originalMaxAge":null,"expires":null,"httpOnly":true,"path":"/"},"flash":{}}'),
	('cIRUPuPpv-2usgqapwd7TT4cFqEm342c', 1589720758, '{"cookie":{"originalMaxAge":null,"expires":null,"httpOnly":true,"path":"/"},"flash":{}}'),
	('cTDKiuMxPz3DmFKg4nnX6HZHeOL4yKTo', 1589680558, '{"cookie":{"originalMaxAge":null,"expires":null,"httpOnly":true,"path":"/"},"flash":{}}'),
	('chdTXnPXAbBozWiabmyS3FiSKdqN7pMq', 1589696758, '{"cookie":{"originalMaxAge":null,"expires":null,"httpOnly":true,"path":"/"},"flash":{}}'),
	('cmm_wqIBR7s64HWjDWu0yPZw1LM2IC3F', 1589697958, '{"cookie":{"originalMaxAge":null,"expires":null,"httpOnly":true,"path":"/"},"flash":{}}'),
	('dtw6gq4I4DNT6OiCrp40mYXCvSzvOdlz', 1589700358, '{"cookie":{"originalMaxAge":null,"expires":null,"httpOnly":true,"path":"/"},"flash":{}}'),
	('dywbUZEwmVS61QjMHhKlSorpq9lLjNsn', 1589728558, '{"cookie":{"originalMaxAge":null,"expires":null,"httpOnly":true,"path":"/"},"flash":{}}'),
	('eCbaAowvyWd65XL_YzrnhV_7f50xlo64', 1589748358, '{"cookie":{"originalMaxAge":null,"expires":null,"httpOnly":true,"path":"/"},"flash":{}}'),
	('eToaD9OA2KM_oYvX5TQYS515R5tMwvnL', 1589713558, '{"cookie":{"originalMaxAge":null,"expires":null,"httpOnly":true,"path":"/"},"flash":{}}'),
	('eXlhP9-Rs0MRfS_CEKtnCgYjvRfkC37d', 1589682358, '{"cookie":{"originalMaxAge":null,"expires":null,"httpOnly":true,"path":"/"},"flash":{}}'),
	('e_pSvPQzk3uyYxyoht6eqgWqPU-ounhl', 1589736358, '{"cookie":{"originalMaxAge":null,"expires":null,"httpOnly":true,"path":"/"},"flash":{}}'),
	('ehRtRxsnqZdTILCnTv3HOcs_rWjan_b_', 1589733358, '{"cookie":{"originalMaxAge":null,"expires":null,"httpOnly":true,"path":"/"},"flash":{}}'),
	('fG-xXQkTz7ziRZSK1cTrE9WX3oM-OnOb', 1589689558, '{"cookie":{"originalMaxAge":null,"expires":null,"httpOnly":true,"path":"/"},"flash":{}}'),
	('fZWxI4SELIlsODhIi7aMdvuyNltye7Rd', 1589726758, '{"cookie":{"originalMaxAge":null,"expires":null,"httpOnly":true,"path":"/"},"flash":{}}'),
	('gkW1FWtQh_4_n7Q0tba2ilcbKPB5_W-4', 1589696158, '{"cookie":{"originalMaxAge":null,"expires":null,"httpOnly":true,"path":"/"},"flash":{}}'),
	('iRfCmUPt_TecxAS288zG06Jog_Ue0KDl', 1589746558, '{"cookie":{"originalMaxAge":null,"expires":null,"httpOnly":true,"path":"/"},"flash":{}}'),
	('j3fx_vl0eJQTM1VCxCLNXCvL0rLGkU7z', 1589706358, '{"cookie":{"originalMaxAge":null,"expires":null,"httpOnly":true,"path":"/"},"flash":{}}'),
	('jlbnqHcA68FcX7ZiWOmRar-AmbZSr4_w', 1589699158, '{"cookie":{"originalMaxAge":null,"expires":null,"httpOnly":true,"path":"/"},"flash":{}}'),
	('kdgpJhHxOerdZ9DxIAbPoFkPCYaFXA3t', 1589722558, '{"cookie":{"originalMaxAge":null,"expires":null,"httpOnly":true,"path":"/"},"flash":{}}'),
	('kiyHzvit7NmEI8PD-qZi-X5ewCYiOY_x', 1589756758, '{"cookie":{"originalMaxAge":null,"expires":null,"httpOnly":true,"path":"/"},"flash":{}}'),
	('lCz-qIywna73pMvLQTnWbjUbDEKjwSJF', 1589683559, '{"cookie":{"originalMaxAge":null,"expires":null,"httpOnly":true,"path":"/"},"flash":{}}'),
	('lFgQ_T6mZpXoFwcfu_gLvwobZvm4FavG', 1589715960, '{"cookie":{"originalMaxAge":null,"expires":null,"httpOnly":true,"path":"/"},"flash":{}}'),
	('lJ03_Y-mG4n82XGHdWYu805e4d9uu5Ms', 1589682958, '{"cookie":{"originalMaxAge":null,"expires":null,"httpOnly":true,"path":"/"},"flash":{}}'),
	('oJpgXCItHzlBvyRqSqDYFFSDUnn_6qtD', 1589673959, '{"cookie":{"originalMaxAge":null,"expires":null,"httpOnly":true,"path":"/"},"flash":{}}'),
	('oMECMNAqMmWZM8d58fIhfOTWmAxT_GwR', 1589672436, '{"cookie":{"originalMaxAge":null,"expires":null,"httpOnly":true,"path":"/"},"flash":{},"passport":{"user":19}}'),
	('oTtampewr6CpOaRwnOqHk-kNfWtY0kWW', 1589717159, '{"cookie":{"originalMaxAge":null,"expires":null,"httpOnly":true,"path":"/"},"flash":{}}'),
	('pYvAPgpk1ojvOz2_GQj6tkSm3Q6CBbQh', 1589745358, '{"cookie":{"originalMaxAge":null,"expires":null,"httpOnly":true,"path":"/"},"flash":{}}'),
	('piolcO4Gal61fZRFXyKfnDybez7ZYhrQ', 1589734560, '{"cookie":{"originalMaxAge":null,"expires":null,"httpOnly":true,"path":"/"},"flash":{}}'),
	('ppkh02oFrmI6IN7YZYAYZbIz4k2xyD9J', 1589698558, '{"cookie":{"originalMaxAge":null,"expires":null,"httpOnly":true,"path":"/"},"flash":{}}'),
	('psmLPw7HH1xMGgNxbmWfAitbrnGNQZ4I', 1589744758, '{"cookie":{"originalMaxAge":null,"expires":null,"httpOnly":true,"path":"/"},"flash":{}}'),
	('qZEOD01AXOycx9Se3IWB56GhRpcUAnT4', 1589730358, '{"cookie":{"originalMaxAge":null,"expires":null,"httpOnly":true,"path":"/"},"flash":{}}'),
	('qfMRun3XeO8qm8irLd8Bybb1xdonWt4m', 1589697360, '{"cookie":{"originalMaxAge":null,"expires":null,"httpOnly":true,"path":"/"},"flash":{}}'),
	('r5TjJuc6MCq4UCESOl5Cg6QcB6lzkRoN', 1589743558, '{"cookie":{"originalMaxAge":null,"expires":null,"httpOnly":true,"path":"/"},"flash":{}}'),
	('rOxHdGzOnA8ckk4e3sCSyBy7e6Jn1ml0', 1589672158, '{"cookie":{"originalMaxAge":null,"expires":null,"httpOnly":true,"path":"/"},"flash":{}}'),
	('rprwEE530KnsS_l4pD3oJyM6Ny_tFM2E', 1589705758, '{"cookie":{"originalMaxAge":null,"expires":null,"httpOnly":true,"path":"/"},"flash":{}}'),
	('rw647x3kID6q3dftIFANba-ajFqI9pcA', 1589717758, '{"cookie":{"originalMaxAge":null,"expires":null,"httpOnly":true,"path":"/"},"flash":{}}'),
	('s_AncFiy-jJ5GyK8HULfZ1yN6Z0gSFyo', 1589706958, '{"cookie":{"originalMaxAge":null,"expires":null,"httpOnly":true,"path":"/"},"flash":{}}'),
	('sj45smGJb6FtFcYtQDNpAbGEgKhV4GN2', 1589707558, '{"cookie":{"originalMaxAge":null,"expires":null,"httpOnly":true,"path":"/"},"flash":{}}'),
	('stmMJBG5vGc41lD5lZlQBFaa-vaE7xRl', 1589735158, '{"cookie":{"originalMaxAge":null,"expires":null,"httpOnly":true,"path":"/"},"flash":{}}'),
	('tglgsf__UOKvF6NDGDErH448Dw3erXz8', 1589729759, '{"cookie":{"originalMaxAge":null,"expires":null,"httpOnly":true,"path":"/"},"flash":{}}'),
	('uXHI3yULHunGWg8GG90dmeGUYu8h03l8', 1589690758, '{"cookie":{"originalMaxAge":null,"expires":null,"httpOnly":true,"path":"/"},"flash":{}}'),
	('uz7pJ5V7v3_r0ygxyyqnu5AF8Xy6TTwG', 1589730958, '{"cookie":{"originalMaxAge":null,"expires":null,"httpOnly":true,"path":"/"},"flash":{}}'),
	('vUUCevcYtJphnCRIGCZU0AHzdHUwOzdT', 1589686558, '{"cookie":{"originalMaxAge":null,"expires":null,"httpOnly":true,"path":"/"},"flash":{}}'),
	('vvc2KmgpDcRwgVbcJpKanoqlOjtxcQd3', 1589727958, '{"cookie":{"originalMaxAge":null,"expires":null,"httpOnly":true,"path":"/"},"flash":{}}'),
	('w_KpPv3jz2GpGGa1p4ahxqyauTRFyOH6', 1589673358, '{"cookie":{"originalMaxAge":null,"expires":null,"httpOnly":true,"path":"/"},"flash":{}}'),
	('wchsRajbH0r87Tp5nkyGENq5Rg5VSA3K', 1589700958, '{"cookie":{"originalMaxAge":null,"expires":null,"httpOnly":true,"path":"/"},"flash":{}}'),
	('x2nfBbmQ500QX08KhR9aLnMXod3AExKM', 1589729158, '{"cookie":{"originalMaxAge":null,"expires":null,"httpOnly":true,"path":"/"},"flash":{}}'),
	('xLHFd5LudEsMJVPp3taRU_EPXOuLVoib', 1589718958, '{"cookie":{"originalMaxAge":null,"expires":null,"httpOnly":true,"path":"/"},"flash":{}}'),
	('xPAvVzWdfowBfO58PNyTiS60a4kD0-qW', 1589731558, '{"cookie":{"originalMaxAge":null,"expires":null,"httpOnly":true,"path":"/"},"flash":{}}'),
	('y0YV2AzWCyXKIwBWTnVXJ98UYxHsLkPJ', 1589738758, '{"cookie":{"originalMaxAge":null,"expires":null,"httpOnly":true,"path":"/"},"flash":{}}'),
	('y1L5mq841mPzcOKGMbT9P_xoiNqqOCbS', 1589710558, '{"cookie":{"originalMaxAge":null,"expires":null,"httpOnly":true,"path":"/"},"flash":{}}'),
	('y9Z_gUZmpisqDXHL7kVALdJ7h1gjzeO9', 1589714758, '{"cookie":{"originalMaxAge":null,"expires":null,"httpOnly":true,"path":"/"},"flash":{}}'),
	('zDjEZQ8y0bqAgvhI66_HDHk9ugHpIuYP', 1589753158, '{"cookie":{"originalMaxAge":null,"expires":null,"httpOnly":true,"path":"/"},"flash":{}}'),
	('zIfSlGNRPxIl4s914jZa_KGTIub21IEu', 1589748958, '{"cookie":{"originalMaxAge":null,"expires":null,"httpOnly":true,"path":"/"},"flash":{}}'),
	('zIzttBGJJGzQQF4NWZQ5T06ANtmakRxy', 1589724958, '{"cookie":{"originalMaxAge":null,"expires":null,"httpOnly":true,"path":"/"},"flash":{}}'),
	('zcJ92i1Zi_oA8fy7kEALPmEoCO5VGmT9', 1589740558, '{"cookie":{"originalMaxAge":null,"expires":null,"httpOnly":true,"path":"/"},"flash":{}}');
/*!40000 ALTER TABLE `sessions` ENABLE KEYS */;

-- Copiando estrutura para tabela kaizuka.usuarios
CREATE TABLE IF NOT EXISTS `usuarios` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(100) NOT NULL,
  `senha` varchar(100) NOT NULL,
  `nome` varchar(50) NOT NULL,
  `admin` enum('Y','N') NOT NULL DEFAULT 'N',
  `ts_new` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ts_upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `u_email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=latin1;

-- Copiando dados para a tabela kaizuka.usuarios: ~5 rows (aproximadamente)
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` (`id`, `email`, `senha`, `nome`, `admin`, `ts_new`, `ts_upd`) VALUES
	(1, 'sergio@gmail.com', '12345', '', 'N', '2020-04-19 21:17:29', '2020-04-20 22:15:16'),
	(2, 'guilherme@gmail.com', '12345', '', 'N', '2020-04-19 21:17:29', '2020-04-20 22:17:27'),
	(3, 'pedro@gmail.com', '12345', '', 'N', '2020-04-19 21:54:55', '2020-04-20 22:17:30'),
	(19, 'sergioferreira.ads@gmail.com', '$2a$10$88lWR8xPFvXEzC24eUT9EuVbAMmQ1DWwGaqcU6qlxRLZmYzQnF0gG', 'Sérgio Ferreira', 'Y', '2020-05-03 18:09:05', '2020-05-03 21:30:44'),
	(20, 'guilherme.maribe@gmail.com', '$2a$10$wg95YgSzj9pSy0fI.Yr1S.vYTHYmH.8kFATiE8.NIOl1lFyC41HKe', 'Guilherme Ribeiro', 'Y', '2020-05-03 22:02:26', '2020-05-03 22:23:13');
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
