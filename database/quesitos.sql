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

-- Copiando estrutura para tabela kaizuka.quesitos2
CREATE TABLE IF NOT EXISTS `quesitos2` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `evt_id` int(11) DEFAULT NULL,
  `descricao` char(20) DEFAULT NULL,
  `ordem` tinyint(3) unsigned DEFAULT NULL,
  `ts_new` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ts_upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `FK_quesitos_eventos` (`evt_id`),
  CONSTRAINT `FK_quesitos_eventos` FOREIGN KEY (`evt_id`) REFERENCES `eventos` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Quesitos de avaliação de cada evento';

-- Exportação de dados foi desmarcado.

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
