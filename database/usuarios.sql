CREATE TABLE `usuarios` (
	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`email` VARCHAR(100) NULL DEFAULT '' COLLATE 'latin1_swedish_ci',
	`senha` VARCHAR(50) NULL DEFAULT '' COLLATE 'latin1_swedish_ci',
	`nome` VARCHAR(50) NULL DEFAULT '' COLLATE 'latin1_swedish_ci',
	`ts_new` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	`ts_upd` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY (`id`) USING BTREE,
	UNIQUE INDEX `u_email` (`email`) USING BTREE
)
COLLATE='latin1_swedish_ci'
ENGINE=InnoDB
AUTO_INCREMENT=4
;
