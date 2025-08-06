import { db } from "~/utils/db.server";
import { useLoaderData } from "react-router";

export async function loader() {
  const users = await db.user.findMany();
  return { users };
}

export async function action({ request }: { request: Request }) {
  const formData = await request.formData();
  const name = formData.get("name");
  const email = formData.get("email");

  if (!name || !email) {
    return { error: "Name and email required" };
  }

  try {
    await db.user.create({ data: { name: String(name), email: String(email) } });
    return { success: true };
  } catch (error) {
    return { error: "Failed to create user" };
  }
}

export default function Users() {
  const { users } = useLoaderData<typeof loader>();

  return (
    <div className="p-6 max-w-2xl mx-auto">
      <h1 className="text-2xl font-bold mb-6">Users</h1>

      {/* Add User Form */}
      <form method="post" className="mb-8 space-y-4 bg-gray-50 p-4 rounded">
        <input
          name="name"
          placeholder="Name"
          required
          className="w-full p-2 border rounded"
        />
        <input
          name="email"
          type="email"
          placeholder="Email"
          required
          className="w-full p-2 border rounded"
        />
        <button
          type="submit"
          className="bg-blue-500 text-white px-4 py-2 rounded hover:bg-blue-600"
        >
          Add User
        </button>
      </form>

      {/* Users List */}
      <div className="space-y-2">
        <h2 className="text-xl font-semibold">All Users ({users.length})</h2>
        {users.length === 0 ? (
          <p className="text-gray-500">No users yet. Add some above!</p>
        ) : (
          <div className="space-y-2">
            {users.map((user: any) => (
              <div key={user.id} className="p-3 border rounded">
                <div className="font-medium">{user.name}</div>
                <div className="text-gray-600">{user.email}</div>
              </div>
            ))}
          </div>
        )}
      </div>
    </div>
  );
}
