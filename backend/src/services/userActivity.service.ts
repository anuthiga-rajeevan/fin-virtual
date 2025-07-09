import prisma from '../prisma';

export async function logUserActivity(userId: string, type: string, metadata?: object) {
  await prisma.userActivity.create({
    data: {
      userId,
      type,
      metadata,
    },
  });
}