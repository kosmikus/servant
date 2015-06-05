{-# LANGUAGE DataKinds          #-}
{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE KindSignatures     #-}
{-# OPTIONS_HADDOCK not-home    #-}
module Servant.API.Method where

import           Data.Typeable (Typeable)

-- | Generic method combinator.
data Method (method :: *) (contentTypes :: [*]) (a :: *)
  deriving Typeable

data MethodDelete
data MethodGet
data MethodPatch
data MethodPost
data MethodPut

--- | Combinator for DELETE requests.
---
--- Example:
---
--- >>>            -- DELETE /books/:isbn
--- >>> type MyApi = "books" :> Capture "isbn" Text :> Delete
newtype Delete (contentTypes :: [*]) (a :: *) =
  Delete (Method MethodDelete contentTypes a)
  deriving Typeable

-- | Endpoint for simple GET requests. Serves the result as JSON.
--
-- Example:
--
-- >>> type MyApi = "books" :> Get '[JSON] [Book]
newtype Get    (contentTypes :: [*]) (a :: *) =
  Get    (Method MethodGet    contentTypes a)
  deriving Typeable

-- | Endpoint for PATCH requests. The type variable represents the type of the
-- response body (not the request body, use 'Servant.API.ReqBody.ReqBody' for
-- that).
--
-- If the HTTP response is empty, only () is supported.
--
-- Example:
--
-- >>>            -- PATCH /books
-- >>>            -- with a JSON encoded Book as the request body
-- >>>            -- returning the just-created Book
-- >>> type MyApi = "books" :> ReqBody '[JSON] Book :> Patch '[JSON] Book
newtype Patch  (contentTypes :: [*]) (a :: *) =
  Patch  (Method MethodPatch  contentTypes a)
  deriving Typeable

-- | Endpoint for POST requests. The type variable represents the type of the
-- response body (not the request body, use 'Servant.API.ReqBody.ReqBody' for
-- that).
--
-- Example:
--
-- >>>            -- POST /books
-- >>>            -- with a JSON encoded Book as the request body
-- >>>            -- returning the just-created Book
-- >>> type MyApi = "books" :> ReqBody '[JSON] Book :> Post '[JSON] Book
newtype Post   (contentTypes :: [*]) (a :: *) =
  Post   (Method MethodPost   contentTypes a)
  deriving Typeable

-- | Endpoint for PUT requests, usually used to update a ressource.
-- The type @a@ is the type of the response body that's returned.
--
-- Example:
--
-- >>> -- PUT /books/:isbn
-- >>> -- with a Book as request body, returning the updated Book
-- >>> type MyApi = "books" :> Capture "isbn" Text :> ReqBody '[JSON] Book :> Put '[JSON] Book
newtype Put    (contentTypes :: [*]) (a :: *) =
  Put    (Method MethodPut    contentTypes a)
  deriving Typeable

-- $setup
-- >>> import Servant.API
-- >>> import Data.Aeson
-- >>> import Data.Text
-- >>> data Book
-- >>> instance ToJSON Book where { toJSON = undefined }

