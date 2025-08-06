import { db } from "~/utils/db.server"

export async function loader() { 
    try {
        await db.$queryRaw`SELECT 1`;
        return new Response("OK", { status: 200 });
    } catch (error) {
        console.error("Healthcheck error:", error);
        return new Response("Internal Server Error", { status: 500 });        
    }
} 