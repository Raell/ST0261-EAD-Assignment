CREATE SCHEMA `spmovy`;

CREATE TABLE `spmovy`.`admin_login` (
    `admin_id` INT NOT NULL AUTO_INCREMENT,
    `username` VARCHAR(100) NOT NULL,
    `password` CHAR(64) NOT NULL,
    `salt` CHAR(64) NOT NULL,
    PRIMARY KEY (`admin_id`)
);

CREATE TABLE `spmovy`.`movie` (
    `movie_id` INT NOT NULL AUTO_INCREMENT,
    `title` VARCHAR(200) NOT NULL,
    `release_date` DATE NULL,
    `description` VARCHAR(100) NULL,
    PRIMARY KEY (`movie_id`)
);

CREATE TABLE `spmovy`.`movie_actors` (
    `name` VARCHAR(200) NOT NULL,
    `movie_id` INT NULL,
    PRIMARY KEY (`name` , `movie_id`),
    FOREIGN KEY (`movie_id`)
        REFERENCES `spmovy`.`movie` (`movie_id`)
        ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE `spmovy`.`movie_timeslots` (
    `timeslot` TIME NOT NULL,
    `movie_id` INT NULL,
    PRIMARY KEY (`timeslot`),
    FOREIGN KEY (`movie_id`)
        REFERENCES `spmovy`.`movie` (`movie_id`)
        ON DELETE CASCADE ON UPDATE NO ACTION
);

CREATE TABLE `spmovy`.`movie_comments` (
    `comment_id` INT NOT NULL,
    `content` VARCHAR(250) NOT NULL,
    `movie_id` INT NOT NULL,
    PRIMARY KEY (`comment_id`),
    FOREIGN KEY (`movie_id`)
        REFERENCES `spmovy`.`movie` (`movie_id`)
        ON DELETE CASCADE ON UPDATE NO ACTION
);

CREATE TABLE `spmovy`.`movie_genre` (
    `genre` VARCHAR(40) NOT NULL,
    `movie_id` INT NULL,
    PRIMARY KEY (`genre` , `movie_id`),
    FOREIGN KEY (`movie_id`)
        REFERENCES `spmovy`.`movie` (`movie_id`)
        ON DELETE CASCADE ON UPDATE NO ACTION
);