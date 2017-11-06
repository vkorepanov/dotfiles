#! /usr/bin/env runhugs +l
--
-- Main.hs
-- Copyright (C) 2017 Korepanov Vyacheslav <real93@live.ru>
--
-- Distributed under terms of the MIT license.
--

{-# LANGUAGE OverloadedStrings #-}

module MyAntigen where

import Antigen

bundles =
    [ bundle "zdharma/fast-syntax-highlighting"
    , (bundle "olivierverdier/zsh-git-prompt") {
        sourcingStrategy = antigenSourcingStrategy
      }
    , bundle "ael-code/zsh-colored-man-pages"
    , bundle "popstas/zsh-command-time"
    ]

config = defaultConfig { plugins = bundles }

main :: IO ()
main = antigen config
