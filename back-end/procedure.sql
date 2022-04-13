DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_competition`(IN `idcompetition` INT, IN `idcircuit` INT, IN `date` DATE, IN `heure` TIME, IN `en_cours` BOOLEAN, IN `tours` INT, IN `nomcompetition` VARCHAR(45))
    NO SQL
INSERT INTO `competition` (`idcompetition`, `idcircuit`, `date`, `heure`, `en_cours`, `tours`, `nomcompetition`) VALUES (NULL, idcircuit, date, heure, en_cours, tours, nomcompetition)$$
DELIMITER ;

SET @p0='1'; SET @p1='1'; SET @p2='2022-02-05'; SET @p3='14:15:30'; SET @p4='0'; SET @p5='9'; SET @p6='test2'; CALL `add_competition`(@p0, @p1, @p2, @p3, @p4, @p5, @p6);
DELETE FROM `competition` WHERE `competition`.`idcompetition` = 15