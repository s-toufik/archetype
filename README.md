# Description

This architecture follows a **pragmatic Hexagonal Architecture with strict dependency inversion and fully isolated infrastructure adapters** approach combined with **Clean Architecture principles**.

The application core is fully isolated from external technologies, frameworks, and infrastructure concerns. All interactions with external systems are expressed through explicit contracts (ports) owned by the application layer, while concrete implementations are delegated to adapters at the system boundaries.

The architecture distinguishes between:

- Business capability abstractions
- Generic technical capability abstractions

## This design enforces:

- Dependency Inversion
- Separation of Concerns
- Framework Independence
- Infrastructure Isolation
- High Testability
- Replaceable Adapters
- Explicit Composition Root / Dependency Injection

## Dependency flow:

- Application Core 
  - ↓ depends on
- Ports (Contracts / Protocols)
  - ↓ implemented by
- Adapters
  - ↓ uses
- External Technologies & Frameworks

## Directory structure

The C++ and Rust architectural patterns are similar to the Python directory structure shown below.

    .
    ├── LICENSE
    ├── Makefile
    ├── main.py
    ├── pyproject.toml
    ├── src/
    │ ├── <project/module name>
    │ │ ├── adapter/              <-│ Business hex
    │ │ │ │ ├── inbound/            │
    │ │ │ │ └── outbound/           │
    │ │ ├── application/            │  
    │ │ │ ├── port/                 │  
    │ │ │ │ ├── inbound/            │
    │ │ │ │ └── outbound/           │
    │ │ │ └── use_case/             │
    │ │ ├── bootstrap/              │
    │ │ ├── domain/               <-│
    │ │ │   ├── base/
    │ │ │   ├── model/
    │ │ │   └── service/
    │ │ └── infrastructure/       <-│ Technical hex
    │ │ │ ├── <concept>/            │  
    │ │ │ │ ├── port/               │
    │ │ │ │ └── adapter/          <-│
    └── tests

> [!NOTE]
> This layered structure is a conceptual representation intended to communicate architectural boundaries clearly. In practice, architectural design is not defined by directory structure but by dependency direction, ownership of abstractions, and enforcement of boundaries at the code level. The folder organization is used here as a documentation tool to improve readability, onboarding, and shared understanding of the system’s design principles.
