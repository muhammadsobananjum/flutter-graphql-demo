
import { connect } from "mongoose";
import  Book  from "../models/book.js";

import { ApolloServerPluginDrainHttpServer } from "apollo-server-core";
import http from "http";
import express from "express";
import cors from "cors";
import { ApolloServer } from "apollo-server-express";

import dotenv from 'dotenv';

// Load environment variables from the .env file
dotenv.config();

const dbUrl: string = process.env.DATABASE_URL;

const app = express();
app.use(cors());
app.use(express.json());
const httpServer = http.createServer(app);



const typeDefs = `#graphql

    


    type Book {
        _id: String
        author: String
        title: String
        year: Int
    }

    input BookInput {
     author: String
        title: String
        year: Int
    }   
        
    type Query {
        hello: String
        getBook(ID: ID!) : Book!
        getBooks(limit :Int):[Book]
    }

    type Mutation {
        createBook(bookInput : BookInput): String!
        updateBook(ID: ID!, bookInput: BookInput) : String!
        deleteBook(ID: ID!): String!
    }
`;

const resolvers = {
    Query: {
        hello: () => "world is good to have anything",

        async getBook(_, { ID }) {
            try {
                return await Book.findById(ID);
            } catch (error) {
                console.error(`Error fetching book with ID ${ID}:`, error);
                throw new Error('Error fetching book');
            }
        },

        async getBooks(_, { limit }) {
            try {
                return await Book.find().limit(limit);
            } catch (error) {
                console.error('Error fetching books:', error);
                throw new Error('Error fetching books');
            }
        }
    },
    Mutation: {
        async createBook(_, { bookInput: { author, title, year } }) {
            try {
                const res = await new Book({ author, title, year }).save();
                return res._id;
            } catch (error) {
                console.error('Error creating book:', error);
                throw new Error('Error creating book');
            }
        },

        async updateBook(_, { ID, bookInput: { author, title, year } }) {
            try {
                await Book.updateOne({ _id: ID }, { $set: { author, title, year } });
                return ID;
            } catch (error) {
                console.error(`Error updating book with ID ${ID}:`, error);
                throw new Error('Error updating book');
            }
        },

        async deleteBook(_, { ID }) {
            try {
                await Book.deleteOne({ _id: ID });
                return ID;
            } catch (error) {
                console.error(`Error deleting book with ID ${ID}:`, error);
                throw new Error('Error deleting book');
            }
        }
    }
};


const startApolloServer = async(app, httpServer) => {
    const server = new ApolloServer({
      typeDefs,
      resolvers,
      plugins: [ApolloServerPluginDrainHttpServer({ httpServer })],
    });
  
    await server.start();
    server.applyMiddleware({ app });
  }


await connect(dbUrl); 
console.log('✅ Database connected successfully');

startApolloServer(app, httpServer);

export default httpServer;



