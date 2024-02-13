import React from 'react';
import { useState, useEffect } from 'react';
import { useRouter } from 'next/router';

interface User {
  username: string;
  // Add other properties if needed
}

export default function Admin() {
  const [user, setUser] = useState<User | null>(null);
  const router = useRouter();

  useEffect(() => {
    const token = localStorage.getItem('token');
    async function fetchUser() {
      const res = await fetch(`${process.env.NEXT_PUBLIC_API_URL}/users/me/`, {
        headers: {
          'Authorization': `Bearer ${token}`
        }
      });
      if (res.status == 200) {
        const json = await res.json();
        setUser(json);
      } else {
        router.push('login');
      }
    }
    fetchUser();
  }, []);

  return (
    <div>
      <h1>Admin</h1>

      {user && (
        <p>{user.username}</p>
      )}
    </div>
  )
}