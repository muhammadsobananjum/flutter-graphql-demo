import app from "./dist/api/index.js";
import consola from "consola";
import dotenv from "dotenv";

dotenv.config();

app.listen(4000, () => consola.info("Server started http://localhost:4000/graphql"));