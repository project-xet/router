# Xet - Router

This is the router component of the Xet framework. It is it's own package in order to encourage an isolated and well tested design.

It uses the Nest specification for web-requests. There is no dispatching/request-processing in this router. Instead, it returns a payload on match. This payload is generic; it could be a struct or a function.

While the router is intended to be used in Xet, it's designed so that it could conceivably be used in other frameworks. It's fairly trivial to write a wrapper around this router that hides it's generic nature.

## Goals

- Make paths first-class values, so they can be referred to, manipulated and used to generate string values
- Be generic over the payload the router returns
- As much type-safety as is comfortable

## Non-Goals

- Resource shortcuts; REST routes
- Scopes, name-spacing shortcuts
- Magically mapping to controllers
- Auto-generating helpers
- Builder style syntax
- Handling 404s

## Todo

- [ ] Implement matching
- [ ] Support matching on content-type
- [ ] Add test suite
- [ ] Document
- [ ] Add examples
- [ ] Think through the generation of strings from paths
