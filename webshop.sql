-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Gép: 127.0.0.1
-- Létrehozás ideje: 2025. Feb 06. 13:36
-- Kiszolgáló verziója: 10.4.32-MariaDB
-- PHP verzió: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Adatbázis: `webshop`
--

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `felhasznalok`
--

CREATE TABLE `felhasznalok` (
  `Id` int(32) NOT NULL,
  `LoginName` varchar(32) NOT NULL,
  `Email` varchar(64) NOT NULL,
  `szamlazasiCimId` int(32) DEFAULT NULL,
  `SALT` varchar(64) NOT NULL,
  `HASH` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `felhasznalok`
--

INSERT INTO `felhasznalok` (`Id`, `LoginName`, `Email`, `szamlazasiCimId`, `SALT`, `HASH`) VALUES
(1, 'user1', 'user1@example.com', NULL, 'sp8i4p6c5m0WwrtVD6xz3LqUIwLlGAdk8ZD73OUaVCGE4zZzBCd16c7J0nMam3Do', 'e518622febbb65115dd1ad163ffaa7e333ac002db2537a37aaad4293081e9384'),
(2, 'user2', 'user2@example.com', NULL, 'sp8i4p6c5m0WwrtVD6xz3LqUIwLlGAdk8ZD73OUaVCGE4zZzBCd16c7J0nMam3Do', 'e518622febbb65115dd1ad163ffaa7e333ac002db2537a37aaad4293081e9384'),
(3, 'admin', 'admin@example.com', NULL, 'sp8i4p6c5m0WwrtVD6xz3LqUIwLlGAdk8ZD73OUaVCGE4zZzBCd16c7J0nMam3Do', 'e518622febbb65115dd1ad163ffaa7e333ac002db2537a37aaad4293081e9384'),
(4, 'user1', 'user1@example.com', 1, 'sp8i4p6c5m0WwrtVD6xz3LqUIwLlGAdk8ZD73OUaVCGE4zZzBCd16c7J0nMam3Do', 'e518622febbb65115dd1ad163ffaa7e333ac002db2537a37aaad4293081e9384'),
(5, 'user2', 'user2@example.com', 2, 'sp8i4p6c5m0WwrtVD6xz3LqUIwLlGAdk8ZD73OUaVCGE4zZzBCd16c7J0nMam3Do', 'e518622febbb65115dd1ad163ffaa7e333ac002db2537a37aaad4293081e9384'),
(6, 'user3', 'user3@example.com', 3, 'sp8i4p6c5m0WwrtVD6xz3LqUIwLlGAdk8ZD73OUaVCGE4zZzBCd16c7J0nMam3Do', 'e518622febbb65115dd1ad163ffaa7e333ac002db2537a37aaad4293081e9384');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `rendelesek`
--

CREATE TABLE `rendelesek` (
  `RendelesSzam` int(32) NOT NULL,
  `Statusz` varchar(32) NOT NULL,
  `felhasznaloId` int(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `szamlazasicimek`
--

CREATE TABLE `szamlazasicimek` (
  `Id` int(32) NOT NULL,
  `Orszag` varchar(32) NOT NULL,
  `Varos` varchar(64) NOT NULL,
  `utca` varchar(64) NOT NULL,
  `hazszam` int(32) NOT NULL,
  `iranyitoszam` int(32) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `szamlazasicimek`
--

INSERT INTO `szamlazasicimek` (`Id`, `Orszag`, `Varos`, `utca`, `hazszam`, `iranyitoszam`) VALUES
(1, 'Magyarország', 'Budapest', 'Kossuth Lajos utca', 15, 1055),
(2, 'Magyarország', 'Debrecen', 'Petőfi Sándor utca', 12, 4025),
(3, 'Magyarország', 'Szeged', 'Dózsa György utca', 8, 6725),
(4, 'Magyarország', 'Budapest', 'Kossuth Lajos utca', 15, 1055),
(5, 'Magyarország', 'Debrecen', 'Petőfi Sándor utca', 12, 4025),
(6, 'Magyarország', 'Szeged', 'Dózsa György utca', 8, 6725);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `termekek`
--

CREATE TABLE `termekek` (
  `Id` int(32) NOT NULL,
  `TermekNeve` varchar(64) NOT NULL,
  `meret` varchar(64) NOT NULL,
  `ar` int(64) NOT NULL,
  `kep` varchar(32) NOT NULL,
  `kategoria` varchar(32) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `termekek`
--

INSERT INTO `termekek` (`Id`, `TermekNeve`, `meret`, `ar`, `kep`, `kategoria`) VALUES
(1, 'Női Ruházat', '[\"S\", \"M\", \"L\"]', 2999, 'kep1.jpg', 'női'),
(2, 'Női Póló', '[\"S\", \"M\", \"L\"]', 2999, 'kep1.jpg', 'Női Ruházat'),
(3, 'Női Póló', '[\"S\", \"M\", \"L\"]', 2999, 'kep1.jpg', 'Női Ruházat'),
(4, 'Női Póló', '[\"S\", \"M\", \"L\"]', 2999, 'kep1.jpg', 'Női Ruházat'),
(5, 'Férfi Póló', '[\"S\", \"M\", \"L\"]', 2999, 'kep1.jpg', 'Férfi Ruházat'),
(6, 'Férfi Póló', '[\"S\", \"M\", \"L\"]', 2999, 'kep1.jpg', 'Férfi Ruházat'),
(7, 'Férfi Póló', '[\"S\", \"M\", \"L\"]', 2999, 'kep1.jpg', 'Férfi Ruházat'),
(8, 'Férfi Póló', '[\"S\", \"M\", \"L\"]', 2999, 'kep1.jpg', 'Férfi Ruházat');

--
-- Indexek a kiírt táblákhoz
--

--
-- A tábla indexei `felhasznalok`
--
ALTER TABLE `felhasznalok`
  ADD PRIMARY KEY (`Id`),
  ADD KEY `LoginNev` (`LoginName`),
  ADD KEY `fk_szamlazasiCim` (`szamlazasiCimId`);

--
-- A tábla indexei `rendelesek`
--
ALTER TABLE `rendelesek`
  ADD PRIMARY KEY (`RendelesSzam`),
  ADD KEY `fk_felhasznalo` (`felhasznaloId`);

--
-- A tábla indexei `szamlazasicimek`
--
ALTER TABLE `szamlazasicimek`
  ADD PRIMARY KEY (`Id`);

--
-- A tábla indexei `termekek`
--
ALTER TABLE `termekek`
  ADD PRIMARY KEY (`Id`);

--
-- A kiírt táblák AUTO_INCREMENT értéke
--

--
-- AUTO_INCREMENT a táblához `felhasznalok`
--
ALTER TABLE `felhasznalok`
  MODIFY `Id` int(32) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT a táblához `rendelesek`
--
ALTER TABLE `rendelesek`
  MODIFY `RendelesSzam` int(32) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT a táblához `szamlazasicimek`
--
ALTER TABLE `szamlazasicimek`
  MODIFY `Id` int(32) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT a táblához `termekek`
--
ALTER TABLE `termekek`
  MODIFY `Id` int(32) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- Megkötések a kiírt táblákhoz
--

--
-- Megkötések a táblához `felhasznalok`
--
ALTER TABLE `felhasznalok`
  ADD CONSTRAINT `fk_szamlazasiCim` FOREIGN KEY (`szamlazasiCimId`) REFERENCES `szamlazasicimek` (`Id`) ON DELETE SET NULL;

--
-- Megkötések a táblához `rendelesek`
--
ALTER TABLE `rendelesek`
  ADD CONSTRAINT `fk_felhasznalo` FOREIGN KEY (`felhasznaloId`) REFERENCES `felhasznalok` (`Id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
