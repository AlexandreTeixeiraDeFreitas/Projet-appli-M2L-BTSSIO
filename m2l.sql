-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : mer. 27 avr. 2022 à 15:03
-- Version du serveur : 10.4.22-MariaDB
-- Version de PHP : 8.1.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `m2l`
--

DELIMITER $$
--
-- Procédures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_abonnee` (IN `idabonnee` INT, IN `nom` VARCHAR(45), IN `email` VARCHAR(45), IN `mdp` VARCHAR(45), IN `prenom` VARCHAR(45), IN `admin` BOOLEAN)  NO SQL
INSERT INTO `abonnee` (`idabonnee`, `nom`, `email`, `mdp`, `prenom`, `admin`) VALUES (idabonnee, nom, email, mdp, prenom, admin)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `add_competition` (IN `idcompetition` INT, IN `idcircuit` INT, IN `date` DATE, IN `heure` TIME, IN `en_cours` BOOLEAN, IN `tours` INT, IN `nomcompetition` VARCHAR(45))  NO SQL
INSERT INTO `competition` (`idcompetition`, `idcircuit`, `date`, `heure`, `en_cours`, `tours`, `nomcompetition`) VALUES (NULL, idcircuit, date, heure, en_cours, tours, nomcompetition)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `add_inscription` (IN `idabonnee` INT, IN `idcompetition` INT)  NO SQL
INSERT INTO `inscription` (`idabonnee`, `idcompetition`) VALUES (idabonnee, idcompetition)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `del_circuit` (IN `idcircuit` INT)  DELETE FROM circuit WHERE circuit.idcircuit = idcircuit$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `del_competition` (IN `idcompetition` INT)  NO SQL
DELETE FROM `competition` WHERE `competition`.`idcompetition` = idcompetition$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `del_inscrit` (IN `idcomp` INT, IN `iduser` INT)  NO SQL
DELETE FROM inscription WHERE inscription.iduser = iduser AND inscription.idcompetition = idcomp$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `inscription` (IN `id` INT(10), IN `idcompetition` INT(10))  NO SQL
INSERT INTO inscription (iduser, idcompetition) VALUES (id, idcompetition)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `inscrit` (IN `id` INT)  NO SQL
SELECT * FROM inscription AS comp
JOIN abonnee AS users
ON comp.idcompetition = id AND comp.iduser = users.idabonnee$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `verify_mdp` (IN `input` VARCHAR(55))  NO SQL
SELECT * FROM abonnee WHERE `abonnee`.`email`=input$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Structure de la table `abonnee`
--

CREATE TABLE `abonnee` (
  `idabonnee` int(11) NOT NULL,
  `nom` varchar(45) DEFAULT NULL,
  `email` varchar(45) DEFAULT NULL,
  `mdp` varchar(45) NOT NULL,
  `prenom` varchar(45) DEFAULT NULL,
  `admin` tinyint(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `abonnee`
--

INSERT INTO `abonnee` (`idabonnee`, `nom`, `email`, `mdp`, `prenom`, `admin`) VALUES
(1, 'Teixeira', 'ardf2002@gmail.com', 'azerty1', 'Alexandre', 1),
(2, 'Vincent', 'a.vincent@ecole.ipssi.net', 'azerty2', 'Alexandre', 1),
(3, 'Benoit', 'antonio@banana.fr', 'azerty3', 'Antoine', 1),
(4, 'Lebacle', 'azerty@gmail.com', 'azerty4', 'Celian', 0),
(7, 'test', 'test@test.com', 'test', 'test', 0),
(8, 'test', 'test@test.com', 'test', 'test', 0),
(14, 'test', 'test@test.com', 'test', 'test', 0),
(34, 'Benoit', 'antoniobenoit@orange.fr', 'as', 'Antoine', 0),
(39, 'test', 'test', 'test', 'test', 0),
(40, 'a', 'a', 'a', 'a', 0),
(46, 'Vincent', 'test@test.com', 'test', 'Alexandre', 0),
(47, 'react', 'react', 'react', 'react', 0),
(48, 'ui', 'ui', 'ui', 'ui', 1);

-- --------------------------------------------------------

--
-- Structure de la table `chat`
--

CREATE TABLE `chat` (
  `idchat` int(11) NOT NULL,
  `idabonnee` int(11) NOT NULL,
  `message` varchar(500) DEFAULT NULL,
  `date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `circuit`
--

CREATE TABLE `circuit` (
  `idcircuit` int(11) NOT NULL,
  `nom` varchar(45) DEFAULT NULL,
  `info` varchar(255) DEFAULT NULL,
  `nbkm` int(10) DEFAULT NULL,
  `img` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `circuit`
--

INSERT INTO `circuit` (`idcircuit`, `nom`, `info`, `nbkm`, `img`) VALUES
(1, 'Circuit d\'Epinal', 'Le circuit est un chemin de terre avec des cotes et des descentes.', 2255, 'epinal'),
(2, 'Circuit de la quiche de lorraine', 'Le circuit est rond avec une route de fromage entourée de lardon sur terrain plate.', 1600, 'quiche');

-- --------------------------------------------------------

--
-- Structure de la table `competition`
--

CREATE TABLE `competition` (
  `idcompetition` int(11) NOT NULL,
  `idcircuit` int(11) NOT NULL,
  `date` varchar(255) DEFAULT NULL,
  `heure` time DEFAULT NULL,
  `en_cours` tinyint(4) DEFAULT NULL,
  `tours` int(10) DEFAULT NULL,
  `nomcompetition` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `competition`
--

INSERT INTO `competition` (`idcompetition`, `idcircuit`, `date`, `heure`, `en_cours`, `tours`, `nomcompetition`) VALUES
(1, 1, '2022-03-31', '14:30:00', 0, 7, 'Coupe de la banane'),
(2, 2, '2022-03-30', '16:30:00', 0, 9, 'Coupe de la choucroute'),
(33, 2, '2022-05-09', '10:00:00', 0, 4, 'Coupe Antoine'),
(35, 1, '2022-04-26', '12:32:00', 0, 5, 'Coupe Ipssi'),
(36, 2, '2022-06-09', '16:00:00', 0, 12, 'Coupe de la saucisse');

-- --------------------------------------------------------

--
-- Structure de la table `inscription`
--

CREATE TABLE `inscription` (
  `iduser` int(11) NOT NULL,
  `idcompetition` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `inscription`
--

INSERT INTO `inscription` (`iduser`, `idcompetition`) VALUES
(3, 2),
(4, 2),
(48, 35),
(48, 36);

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `abonnee`
--
ALTER TABLE `abonnee`
  ADD PRIMARY KEY (`idabonnee`);

--
-- Index pour la table `chat`
--
ALTER TABLE `chat`
  ADD PRIMARY KEY (`idchat`),
  ADD KEY `fk_Chat_Abonnee1_idx` (`idabonnee`);

--
-- Index pour la table `circuit`
--
ALTER TABLE `circuit`
  ADD PRIMARY KEY (`idcircuit`);

--
-- Index pour la table `competition`
--
ALTER TABLE `competition`
  ADD PRIMARY KEY (`idcompetition`),
  ADD KEY `fk_Competition_Circuit1_idx` (`idcircuit`);

--
-- Index pour la table `inscription`
--
ALTER TABLE `inscription`
  ADD PRIMARY KEY (`iduser`,`idcompetition`),
  ADD KEY `fk_Abonnée_has_Competition_Competition1_idx` (`idcompetition`),
  ADD KEY `fk_Abonnée_has_Competition_Abonnée1_idx` (`iduser`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `abonnee`
--
ALTER TABLE `abonnee`
  MODIFY `idabonnee` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=49;

--
-- AUTO_INCREMENT pour la table `chat`
--
ALTER TABLE `chat`
  MODIFY `idchat` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `circuit`
--
ALTER TABLE `circuit`
  MODIFY `idcircuit` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT pour la table `competition`
--
ALTER TABLE `competition`
  MODIFY `idcompetition` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `chat`
--
ALTER TABLE `chat`
  ADD CONSTRAINT `fk_Chat_Abonnee1` FOREIGN KEY (`idabonnee`) REFERENCES `abonnee` (`idabonnee`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `competition`
--
ALTER TABLE `competition`
  ADD CONSTRAINT `fk_Competition_Circuit1` FOREIGN KEY (`idcircuit`) REFERENCES `circuit` (`idcircuit`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `inscription`
--
ALTER TABLE `inscription`
  ADD CONSTRAINT `fk_Abonnée_has_Competition_Abonnée1` FOREIGN KEY (`iduser`) REFERENCES `abonnee` (`idabonnee`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Abonnée_has_Competition_Competition1` FOREIGN KEY (`idcompetition`) REFERENCES `competition` (`idcompetition`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
