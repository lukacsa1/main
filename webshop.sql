-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Gép: 127.0.0.1
-- Létrehozás ideje: 2024. Dec 01. 09:48
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
  `LoginNev` varchar(32) NOT NULL,
  `Jelszo` varchar(32) NOT NULL,
  `Email` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `rendelesek`
--

CREATE TABLE `rendelesek` (
  `RendelesSzam` int(32) NOT NULL,
  `Statusz` varchar(32) NOT NULL
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
-- Indexek a kiírt táblákhoz
--

--
-- A tábla indexei `felhasznalok`
--
ALTER TABLE `felhasznalok`
  ADD PRIMARY KEY (`Id`),
  ADD KEY `LoginNev` (`LoginNev`);

--
-- A tábla indexei `rendelesek`
--
ALTER TABLE `rendelesek`
  ADD PRIMARY KEY (`RendelesSzam`);

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
  MODIFY `Id` int(32) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT a táblához `termekek`
--
ALTER TABLE `termekek`
  MODIFY `Id` int(32) NOT NULL AUTO_INCREMENT;

--
-- Megkötések a kiírt táblákhoz
--

--
-- Megkötések a táblához `felhasznalok`
--
ALTER TABLE `felhasznalok`
  ADD CONSTRAINT `felhasznalok_ibfk_1` FOREIGN KEY (`Id`) REFERENCES `szamlazasicimek` (`Id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
