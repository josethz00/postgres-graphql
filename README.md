# Postgres-GraphQL

This project demonstrates how to create a powerful and efficient GraphQL API using PostgreSQL and the PostGraphile extension. PostGraphile automatically generates a fully-featured GraphQL API from your PostgreSQL database schema.

## Table of Contents
1. [Features](#features)
2. [Prerequisites](#prerequisites)
3. [Getting Started](#getting-started)
4. [Querying and Mutating](#querying-and-mutating)

## Features

- **Auto-Generated Schema**: Instantly get a full CRUD GraphQL API based on your PostgreSQL schema.
- **Real-time Updates**: Subscribe to changes in your database and get real-time updates.
- **Custom Business Logic**: Embed business logic directly in your database with PL/pgSQL functions.
- **Efficient Data Fetching**: PostGraphile generates efficient SQL queries, minimizing the number of database hits.

## Prerequisites

Before you begin, ensure you have met the following requirements:
- [Node.js](https://nodejs.org/) and npm installed.
- Access to a PostgreSQL database.
- Basic knowledge of GraphQL and PostgreSQL.

## Getting Started

To get a local copy up and running, follow these steps:

1. **Install PostGraphile Globally**:

```sh
   npm install -g postgraphile
```

2. **Run a PostgreSQL instance**:

You can use Docker and Docker-compose if you want

```sh
docker-compose up --build
```

3. Usage

This command will start the GraphQL API

```sh
yarn start:dev
```

or 

```sh
npm run start:dev
```

and it will be available at the Playground http://localhost:5000/graphiql

## Querying and Mutating

```graphql
query {
  allUsers {
    nodes {
      id
      name
      email
    }
  }
}
```

or a mutation

```graphql
mutation {
  createUser(input: {user: {name: "John Doe", email: "john.doe@example.com"}}) {
    user {
      id
      name
      email
    }
  }
}
```
