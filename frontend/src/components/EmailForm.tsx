'use client'

import { useState } from 'react'

export default function EmailForm() {
  const [email, setEmail] = useState('')

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault()
    console.log('Email submitted:', email)
    // Add your logic here
  }

  return (
    <div className="flex items-center justify-center min-h-screen px-4">
      <form
        onSubmit={handleSubmit}
        className="bg-white dark:bg-zinc-900 p-8 rounded-xl shadow-md w-full max-w-md border border-gray-200 dark:border-zinc-800"
      >
        <h2 className="text-2xl font-semibold mb-6 text-center text-foreground">
          Enter your email
        </h2>
        <input
          type="email"
          required
          placeholder="you@example.com"
          value={email}
          onChange={(e) => setEmail(e.target.value)}
          className="w-full px-4 py-3 border border-gray-300 dark:border-zinc-700 bg-transparent text-foreground rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500 mb-4"
        />
        <button
          type="submit"
          className="w-full bg-blue-600 hover:bg-blue-700 text-white py-3 rounded-md transition font-medium"
        >
          Continue
        </button>
      </form>
    </div>
  )
}
