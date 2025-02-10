-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Gép: 127.0.0.1
-- Létrehozás ideje: 2025. Feb 10. 11:20
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
(1, 'Női Póló', '[\"S\", \"M\", \"L\"]', 2999, 'kep1.jpg', 'Női'),
(2, 'Női Póló', '[\"S\", \"M\", \"L\"]', 2999, 'kep2.jpg', 'Női'),
(3, 'Női Póló', '[\"S\", \"M\", \"L\"]', 2999, 'kep3.jpg', 'Női'),
(4, 'Női Póló', '[\"S\", \"M\", \"L\"]', 2999, 'kep4.jpg', 'Női'),
(5, 'Férfi Póló', '[\"S\", \"M\", \"L\"]', 2999, 'kep5.jpg', 'Férfi'),
(6, 'Férfi Póló', '[\"S\", \"M\", \"L\"]', 2999, 'kep6.jpg', 'Férfi'),
(7, 'Férfi Póló', '[\"S\", \"M\", \"L\"]', 2999, 'kep7.jpg', 'Férfi'),
(8, 'Férfi Póló', '[\"S\", \"M\", \"L\"]', 2999, 'kep8.jpg', 'Férfi'),
(9, 'Női Blúz', '[\"L\", \"XL\", \"XXL\"]', 3999, 'kep9.jpg', 'Női'),
(10, 'Női Blúz', '[\"L\", \"XL\", \"XXL\"]', 4299, 'kep10.jpg', 'Női'),
(11, 'Női Blúz', '[\"L\", \"XL\", \"XXL\"]', 4599, 'kep11.jpg', 'Női'),
(12, 'Férfi Ing', '[\"L\", \"XL\", \"XXL\"]', 4999, 'kep12.jpg', 'Férfi'),
(13, 'Férfi Ing', '[\"L\", \"XL\", \"XXL\"]', 5299, 'kep13.jpg', 'Férfi'),
(14, 'Férfi Ing', '[\"L\", \"XL\", \"XXL\"]', 5599, 'kep14.jpg', 'Férfi'),
(15, 'Női Blúz', '[\"L\", \"XL\", \"XXL\"]', 4199, 'kep15.jpg', 'Női'),
(16, 'Női Blúz', '[\"L\", \"XL\", \"XXL\"]', 4499, 'kep16.jpg', 'Női'),
(17, 'Férfi Ing', '[\"L\", \"XL\", \"XXL\"]', 4899, 'kep17.jpg', 'Férfi'),
(18, 'Férfi Ing', '[\"L\", \"XL\", \"XXL\"]', 5199, 'kep18.jpg', 'Férfi'),
(19, 'Női Blúz', '[\"L\", \"XL\", \"XXL\"]', 4799, 'kep19.jpg', 'Női'),
(20, 'Női Blúz', '[\"L\", \"XL\", \"XXL\"]', 4599, 'kep20.jpg', 'Női'),
(21, 'Férfi Ing', '[\"L\", \"XL\", \"XXL\"]', 5499, 'kep21.jpg', 'Férfi'),
(22, 'Férfi Ing', '[\"L\", \"XL\", \"XXL\"]', 5699, 'kep22.jpg', 'Férfi'),
(23, 'Női Blúz', '[\"L\", \"XL\", \"XXL\"]', 4399, 'kep23.jpg', 'Női'),
(24, 'Női Blúz', '[\"L\", \"XL\", \"XXL\"]', 4999, 'kep24.jpg', 'Női'),
(25, 'Férfi Ing', '[\"L\", \"XL\", \"XXL\"]', 4799, 'kep25.jpg', 'Férfi'),
(26, 'Férfi Ing', '[\"L\", \"XL\", \"XXL\"]', 5299, 'kep26.jpg', 'Férfi'),
(27, 'Női Póló', '[\"L\", \"XL\", \"XXL\"]', 4599, 'kep27.jpg', 'Női'),
(28, 'Női Póló', '[\"L\", \"XL\", \"XXL\"]', 5199, 'kep28.jpg', 'Női'),
(29, 'Férfi Póló', '[\"L\", \"XL\", \"XXL\"]', 5399, 'kep29.jpg', 'Férfi'),
(30, 'Férfi Póló', '[\"L\", \"XL\", \"XXL\"]', 5599, 'kep30.jpg', 'Férfi'),
(31, 'Női Póló', '[\"L\", \"XL\", \"XXL\"]', 4999, 'kep31.jpg', 'Női'),
(32, 'Női Póló', '[\"L\", \"XL\", \"XXL\"]', 4799, 'kep32.jpg', 'Női'),
(33, 'Férfi Póló', '[\"L\", \"XL\", \"XXL\"]', 5699, 'kep33.jpg', 'Férfi'),
(34, 'Férfi Póló', '[\"L\", \"XL\", \"XXL\"]', 5899, 'kep34.jpg', 'Férfi'),
(35, 'Női Póló', '[\"L\", \"XL\", \"XXL\"]', 4599, 'kep35.jpg', 'Női'),
(36, 'Női Póló', '[\"L\", \"XL\", \"XXL\"]', 4999, 'kep36.jpg', 'Női'),
(37, 'Férfi Póló', '[\"L\", \"XL\", \"XXL\"]', 5499, 'kep37.jpg', 'Férfi'),
(38, 'Férfi Póló', '[\"L\", \"XL\", \"XXL\"]', 5999, 'kep38.jpg', 'Férfi');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `user`
--

CREATE TABLE `user` (
  `Id` int(32) NOT NULL,
  `LoginName` varchar(32) NOT NULL,
  `Email` varchar(64) NOT NULL,
  `szamlazasiCimId` int(32) DEFAULT NULL,
  `SALT` varchar(64) NOT NULL,
  `HASH` varchar(64) NOT NULL,
  `Active` int(1) NOT NULL,
  `RegistarionDate` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `PermissionLevel` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `user`
--

INSERT INTO `user` (`Id`, `LoginName`, `Email`, `szamlazasiCimId`, `SALT`, `HASH`, `Active`, `RegistarionDate`, `PermissionLevel`) VALUES
(1, 'user1', 'user1@example.com', NULL, 'sp8i4p6c5m0WwrtVD6xz3LqUIwLlGAdk8ZD73OUaVCGE4zZzBCd16c7J0nMam3Do', 'e518622febbb65115dd1ad163ffaa7e333ac002db2537a37aaad4293081e9384', 0, '2025-02-09 17:38:04', 0),
(2, 'user2', 'user2@example.com', NULL, 'sp8i4p6c5m0WwrtVD6xz3LqUIwLlGAdk8ZD73OUaVCGE4zZzBCd16c7J0nMam3Do', 'e518622febbb65115dd1ad163ffaa7e333ac002db2537a37aaad4293081e9384', 0, '2025-02-09 17:38:04', 0),
(3, 'admin', 'admin@example.com', NULL, 'sp8i4p6c5m0WwrtVD6xz3LqUIwLlGAdk8ZD73OUaVCGE4zZzBCd16c7J0nMam3Do', 'e518622febbb65115dd1ad163ffaa7e333ac002db2537a37aaad4293081e9384', 0, '2025-02-09 17:38:04', 0),
(4, 'user1', 'user1@example.com', 1, 'sp8i4p6c5m0WwrtVD6xz3LqUIwLlGAdk8ZD73OUaVCGE4zZzBCd16c7J0nMam3Do', 'e518622febbb65115dd1ad163ffaa7e333ac002db2537a37aaad4293081e9384', 0, '2025-02-09 17:38:04', 0),
(5, 'user2', 'user2@example.com', 2, 'sp8i4p6c5m0WwrtVD6xz3LqUIwLlGAdk8ZD73OUaVCGE4zZzBCd16c7J0nMam3Do', 'e518622febbb65115dd1ad163ffaa7e333ac002db2537a37aaad4293081e9384', 0, '2025-02-09 17:38:04', 0),
(6, 'user3', 'user3@example.com', 3, 'sp8i4p6c5m0WwrtVD6xz3LqUIwLlGAdk8ZD73OUaVCGE4zZzBCd16c7J0nMam3Do', 'e518622febbb65115dd1ad163ffaa7e333ac002db2537a37aaad4293081e9384', 0, '2025-02-09 17:38:04', 0);

--
-- Indexek a kiírt táblákhoz
--

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
-- A tábla indexei `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`Id`),
  ADD KEY `LoginNev` (`LoginName`),
  ADD KEY `fk_szamlazasiCim` (`szamlazasiCimId`);

--
-- A kiírt táblák AUTO_INCREMENT értéke
--

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
  MODIFY `Id` int(32) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- AUTO_INCREMENT a táblához `user`
--
ALTER TABLE `user`
  MODIFY `Id` int(32) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- Megkötések a kiírt táblákhoz
--

--
-- Megkötések a táblához `rendelesek`
--
ALTER TABLE `rendelesek`
  ADD CONSTRAINT `fk_felhasznalo` FOREIGN KEY (`felhasznaloId`) REFERENCES `user` (`Id`) ON DELETE CASCADE;

--
-- Megkötések a táblához `user`
--
ALTER TABLE `user`
  ADD CONSTRAINT `fk_szamlazasiCim` FOREIGN KEY (`szamlazasiCimId`) REFERENCES `szamlazasicimek` (`Id`) ON DELETE SET NULL;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
