CREATE TABLE `eventos` (
	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`descricao` VARCHAR(100) NULL DEFAULT NULL COLLATE 'latin1_swedish_ci',
	`ts_ini` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
	`ts_fim` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
	`editar` CHAR(1) NULL DEFAULT '0' COLLATE 'latin1_swedish_ci',
	`votar` CHAR(1) NULL DEFAULT '0' COLLATE 'latin1_swedish_ci',
	`ts_new` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
	`ts_upd` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY (`id`) USING BTREE
)
COLLATE='latin1_swedish_ci'
ENGINE=InnoDB
AUTO_INCREMENT=2
;
