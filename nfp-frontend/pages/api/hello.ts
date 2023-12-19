// Next.js API route support: https://nextjs.org/docs/api-routes/introduction
import { NextApiRequest, NextApiResponse } from 'next';

export default function handler(req: NextApiRequest, res: NextApiResponse) {
  try {
    return res.status(200).json({ name: 'John Doe' });
  } catch (error) {
      console.log(error);
      return res.status(400).end();
  }
}
