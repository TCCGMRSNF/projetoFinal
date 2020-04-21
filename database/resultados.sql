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

-- Exportação de dados foi desmarcado.

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
