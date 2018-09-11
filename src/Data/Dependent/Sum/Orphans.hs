{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE UndecidableInstances #-}
module Data.Dependent.Sum.Orphans where

import Data.Aeson
import Data.Constraint
import Data.Constraint.Forall
import Data.Constraint.Extras
import Data.Dependent.Map (DMap, GCompare)
import qualified Data.Dependent.Map as DMap
import Data.Dependent.Sum
import Data.Some (Some)
import qualified Data.Some as Some

instance (ForallF ToJSON f, Has ToJSON f, ToJSON1 g) => ToJSON (DSum f g) where
  toJSON ((f :: f a) :=> (x :: g a))
    | Dict :: Dict (ToJSON a) <- argDict f
    = toJSON (toJSON f \\ (instF :: ForallF ToJSON f :- ToJSON (f a)), toJSON1 x)

instance (ForallF ToJSON f, Has ToJSON f, ToJSON1 g) => ToJSON (DMap f g) where
    toJSON = toJSON . DMap.toList

instance (FromJSON (Some f), GCompare f, Has FromJSON f, FromJSON1 g) => FromJSON (DSum f g) where
  parseJSON x = do
    (tag, val) <- parseJSON x
    Some.This (parsedTag :: f a) <- parseJSON tag
    val' <- case argDict parsedTag of
      (Dict :: Dict (FromJSON a)) -> parseJSON1 val
    return $ parsedTag :=> val'

instance (FromJSON (Some f), GCompare f, Has FromJSON f, FromJSON1 g) => FromJSON (DMap f g) where
    parseJSON = fmap DMap.fromList . parseJSON
