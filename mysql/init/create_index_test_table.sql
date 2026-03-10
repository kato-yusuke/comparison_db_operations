CREATE TABLE `index_test_table` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `int_1` INT UNSIGNED,
    `int_2` INT UNSIGNED,
    `int_3` INT UNSIGNED,
    `int_4` INT UNSIGNED,
    `varchar_1` VARCHAR(40),
    `varchar_2` VARCHAR(40),
    `varchar_3` VARCHAR(40),
    `varchar_4` VARCHAR(40),
    `datetime_1` DATETIME,
    `datetime_2` DATETIME,
    `datetime_3` DATETIME,
    `datetime_4` DATETIME,
    PRIMARY KEY (id)
);


CREATE TABLE `index_test_table_no_index` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `int_1` INT UNSIGNED,
    `int_2` INT UNSIGNED,
    `int_3` INT UNSIGNED,
    `int_4` INT UNSIGNED,
    `varchar_1` VARCHAR(40),
    `varchar_2` VARCHAR(40),
    `varchar_3` VARCHAR(40),
    `varchar_4` VARCHAR(40),
    `datetime_1` DATETIME,
    `datetime_2` DATETIME,
    `datetime_3` DATETIME,
    `datetime_4` DATETIME,
    PRIMARY KEY (id)
);


CREATE TABLE `index_test_table_single_int_index` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `int_1` INT UNSIGNED,
    `int_2` INT UNSIGNED,
    `int_3` INT UNSIGNED,
    `int_4` INT UNSIGNED,
    `varchar_1` VARCHAR(40),
    `varchar_2` VARCHAR(40),
    `varchar_3` VARCHAR(40),
    `varchar_4` VARCHAR(40),
    `datetime_1` DATETIME,
    `datetime_2` DATETIME,
    `datetime_3` DATETIME,
    `datetime_4` DATETIME,
    PRIMARY KEY (id)
);

CREATE INDEX int_1_index ON index_test_table_single_int_index (int_1);
CREATE INDEX int_2_index ON index_test_table_single_int_index (int_2);
CREATE INDEX int_3_index ON index_test_table_single_int_index (int_3);
CREATE INDEX int_4_index ON index_test_table_single_int_index (int_4);


CREATE TABLE `index_test_table_single_text_index` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `int_1` INT UNSIGNED,
    `int_2` INT UNSIGNED,
    `int_3` INT UNSIGNED,
    `int_4` INT UNSIGNED,
    `varchar_1` VARCHAR(40),
    `varchar_2` VARCHAR(40),
    `varchar_3` VARCHAR(40),
    `varchar_4` VARCHAR(40),
    `datetime_1` DATETIME,
    `datetime_2` DATETIME,
    `datetime_3` DATETIME,
    `datetime_4` DATETIME,
    PRIMARY KEY (id)
);

CREATE INDEX text_1_index ON index_test_table_single_text_index (varchar_1);
CREATE INDEX text_2_index ON index_test_table_single_text_index (varchar_2);
CREATE INDEX text_3_index ON index_test_table_single_text_index (varchar_3);
CREATE INDEX text_4_index ON index_test_table_single_text_index (varchar_4);


CREATE TABLE `index_test_table_single_datetime_index` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `int_1` INT UNSIGNED,
    `int_2` INT UNSIGNED,
    `int_3` INT UNSIGNED,
    `int_4` INT UNSIGNED,
    `varchar_1` VARCHAR(40),
    `varchar_2` VARCHAR(40),
    `varchar_3` VARCHAR(40),
    `varchar_4` VARCHAR(40),
    `datetime_1` DATETIME,
    `datetime_2` DATETIME,
    `datetime_3` DATETIME,
    `datetime_4` DATETIME,
    PRIMARY KEY (id)
);

CREATE INDEX datetime_1_index ON index_test_table_single_datetime_index (datetime_1);
CREATE INDEX datetime_2_index ON index_test_table_single_datetime_index (datetime_2);
CREATE INDEX datetime_3_index ON index_test_table_single_datetime_index (datetime_3);
CREATE INDEX datetime_4_index ON index_test_table_single_datetime_index (datetime_4);


CREATE TABLE `index_test_table_multiple_int_index` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `int_1` INT UNSIGNED,
    `int_2` INT UNSIGNED,
    `int_3` INT UNSIGNED,
    `int_4` INT UNSIGNED,
    `varchar_1` VARCHAR(40),
    `varchar_2` VARCHAR(40),
    `varchar_3` VARCHAR(40),
    `varchar_4` VARCHAR(40),
    `datetime_1` DATETIME,
    `datetime_2` DATETIME,
    `datetime_3` DATETIME,
    `datetime_4` DATETIME,
    PRIMARY KEY (id)
);

CREATE INDEX int_index ON index_test_table_multiple_int_index (int_2, int_3, int_4, int_1);


CREATE TABLE `index_test_table_multiple_text_index` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `int_1` INT UNSIGNED,
    `int_2` INT UNSIGNED,
    `int_3` INT UNSIGNED,
    `int_4` INT UNSIGNED,
    `varchar_1` VARCHAR(40),
    `varchar_2` VARCHAR(40),
    `varchar_3` VARCHAR(40),
    `varchar_4` VARCHAR(40),
    `datetime_1` DATETIME,
    `datetime_2` DATETIME,
    `datetime_3` DATETIME,
    `datetime_4` DATETIME,
    PRIMARY KEY (id)
);

CREATE INDEX text_index ON index_test_table_multiple_text_index (varchar_2, varchar_3, varchar_4, varchar_1);


CREATE TABLE `index_test_table_multiple_datetime_index` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `int_1` INT UNSIGNED,
    `int_2` INT UNSIGNED,
    `int_3` INT UNSIGNED,
    `int_4` INT UNSIGNED,
    `varchar_1` VARCHAR(40),
    `varchar_2` VARCHAR(40),
    `varchar_3` VARCHAR(40),
    `varchar_4` VARCHAR(40),
    `datetime_1` DATETIME,
    `datetime_2` DATETIME,
    `datetime_3` DATETIME,
    `datetime_4` DATETIME,
    PRIMARY KEY (id)
);

CREATE INDEX datetime_index ON index_test_table_multiple_datetime_index (datetime_2, datetime_3, datetime_4, datetime_1);


CREATE TABLE `index_test_table_multiple_index_1` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `int_1` INT UNSIGNED,
    `int_2` INT UNSIGNED,
    `int_3` INT UNSIGNED,
    `int_4` INT UNSIGNED,
    `varchar_1` VARCHAR(40),
    `varchar_2` VARCHAR(40),
    `varchar_3` VARCHAR(40),
    `varchar_4` VARCHAR(40),
    `datetime_1` DATETIME,
    `datetime_2` DATETIME,
    `datetime_3` DATETIME,
    `datetime_4` DATETIME,
    PRIMARY KEY (id)
);

CREATE INDEX int_text_datetime_1_index ON index_test_table_multiple_index_1 (int_1, varchar_1, datetime_1);


CREATE TABLE `index_test_table_multiple_index_2` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `int_1` INT UNSIGNED,
    `int_2` INT UNSIGNED,
    `int_3` INT UNSIGNED,
    `int_4` INT UNSIGNED,
    `varchar_1` VARCHAR(40),
    `varchar_2` VARCHAR(40),
    `varchar_3` VARCHAR(40),
    `varchar_4` VARCHAR(40),
    `datetime_1` DATETIME,
    `datetime_2` DATETIME,
    `datetime_3` DATETIME,
    `datetime_4` DATETIME,
    PRIMARY KEY (id)
);

CREATE INDEX int_text_datetime_2_index ON index_test_table_multiple_index_2 (int_2, varchar_2, datetime_2);


CREATE TABLE `index_test_table_multiple_index_3` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `int_1` INT UNSIGNED,
    `int_2` INT UNSIGNED,
    `int_3` INT UNSIGNED,
    `int_4` INT UNSIGNED,
    `varchar_1` VARCHAR(40),
    `varchar_2` VARCHAR(40),
    `varchar_3` VARCHAR(40),
    `varchar_4` VARCHAR(40),
    `datetime_1` DATETIME,
    `datetime_2` DATETIME,
    `datetime_3` DATETIME,
    `datetime_4` DATETIME,
    PRIMARY KEY (id)
);

CREATE INDEX int_text_datetime_3_index ON index_test_table_multiple_index_3 (int_3, varchar_3, datetime_3);


CREATE TABLE `index_test_table_multiple_index_4` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `int_1` INT UNSIGNED,
    `int_2` INT UNSIGNED,
    `int_3` INT UNSIGNED,
    `int_4` INT UNSIGNED,
    `varchar_1` VARCHAR(40),
    `varchar_2` VARCHAR(40),
    `varchar_3` VARCHAR(40),
    `varchar_4` VARCHAR(40),
    `datetime_1` DATETIME,
    `datetime_2` DATETIME,
    `datetime_3` DATETIME,
    `datetime_4` DATETIME,
    PRIMARY KEY (id)
);

CREATE INDEX int_text_datetime_4_index ON index_test_table_multiple_index_4 (int_4, varchar_4, datetime_4);
