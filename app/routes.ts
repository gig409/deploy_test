import { type RouteConfig, index, route } from "@react-router/dev/routes";

export default [
  index("routes/home.tsx"),
  route("/users-simple", "routes/users-simple.tsx"),
] satisfies RouteConfig;
