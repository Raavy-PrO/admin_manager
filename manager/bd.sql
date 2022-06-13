CREATE TABLE `account_manager` (
	`id` INT(11) UNSIGNED NOT NULL,
	`username` VARCHAR(50) NULL DEFAULT 'Raavy' COLLATE 'utf8mb4_general_ci',
	`senha` VARCHAR(50) NOT NULL DEFAULT '' COLLATE 'utf8mb4_general_ci',
	`groups` VARCHAR(50) NOT NULL DEFAULT 'policia.permissao' COLLATE 'utf8mb4_general_ci'
)
COLLATE='utf8mb4_general_ci'
ENGINE=InnoDB
;

CREATE TABLE `bank_manager` (
	`id` INT(11) NULL DEFAULT NULL,
	`bank` INT(11) UNSIGNED NOT NULL
)
COLLATE='utf8mb4_general_ci'
ENGINE=InnoDB
;
