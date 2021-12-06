import Head from 'next/head'
import { useState, useEffect } from 'react';

export default function Notes() {
  const [note, setNote] = useState('');
  const [notes, setNotes] = useState([]);

  useEffect(() => {
    async function fetchNotes() {
      const res = await fetch(`${process.env.NEXT_PUBLIC_API_URL}/notes/`);
      const json = await res.json();
      console.log(json)
      setNotes(json);
    }
    fetchNotes();
  }, [])

  function handleChange(e) {
    setNote(e.target.value);
  }

  async function handleSubmit() {
    const res = await fetch(`${process.env.NEXT_PUBLIC_API_URL}/notes/`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({
        text: note,
        completed: false
      })
    })
    const json = await res.json();
    setNotes([...notes, json])
  }

  return (
    <div>
      <Head>
        <title>Notes</title>
      </Head>
      <div className="container mx-auto p-10 m-10">
        <div className="flex flex-col">
          <h1 className="font-bold mb-3">Notes</h1>
          <textarea value={note} onChange={handleChange} className="border-2" ></textarea>
          <div className="mx-auto p-3 m-5">
            <button onClick={handleSubmit} className="bg-green-500 p-3 text-white">Submit</button>
          </div>
          <div>
            <ul>
              {notes && notes.map((note) =>
                  <li key={note.id} className="bg-yellow-100 m-3 p-3 border-yellow-200 border-2">{note.text}</li>
              )}
            </ul>
          </div>
        </div>
      </div>
    </div>
  )
}