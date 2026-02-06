import { createMiddlewareClient } from '@supabase/auth-helpers-nextjs';
import { NextResponse } from 'next/server';
import type { NextRequest } from 'next/server';

export async function middleware(req: NextRequest) {
  const res = NextResponse.next();

  const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL;
  const supabaseKey = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY;

  // Skip auth check if Supabase not configured
  if (!supabaseUrl || !supabaseKey) {
    return res;
  }

  const supabase = createMiddlewareClient({ req, res });
  const { data: { session } } = await supabase.auth.getSession();

  // Redirect to login if no session on protected routes
  if (!session) {
    const redirectUrl = req.nextUrl.clone();
    redirectUrl.pathname = '/login';
    return NextResponse.redirect(redirectUrl);
  }

  return res;
}

export const config = {
  matcher: ['/dashboard/:path*', '/admin/:path*', '/client/:path*'],
};
