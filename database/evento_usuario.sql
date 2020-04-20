CREATE TABLE `evento_usuario` (
	`evt_id` INT(11) NOT NULL,
	`usr_id` INT(11) NOT NULL,
	`funcao` CHAR(1) NOT NULL COLLATE 'latin1_swedish_ci',
	`ts_new` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	`ts_upd` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	UNIQUE INDEX `Index 3` (`evt_id`, `usr_id`, `funcao`) USING BTREE,
	INDEX `FK_evento_usuario_usuarios` (`usr_id`) USING BTREE,
	CONSTRAINT `FK_evento_usuario_eventos` FOREIGN KEY (`evt_id`) REFERENCES `kaizuka`.`eventos` (`id`) ON UPDATE RESTRICT ON DELETE RESTRICT,
	CONSTRAINT `FK_evento_usuario_usuarios` FOREIGN KEY (`usr_id`) REFERENCES `kaizuka`.`usuarios` (`id`) ON UPDATE RESTRICT ON DELETE RESTRICT
)
COLLATE='latin1_swedish_ci'
ENGINE=InnoDB
;
