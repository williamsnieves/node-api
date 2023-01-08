/*
  Warnings:

  - You are about to alter the column `name` on the `Product` table. The data in that column could be lost. The data in that column will be cast from `Text` to `VarChar(255)`.
  - The `status` column on the `Update` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - You are about to drop the column `updatedId` on the `UpdatePoint` table. All the data in the column will be lost.
  - Added the required column `updateId` to the `UpdatePoint` table without a default value. This is not possible if the table is not empty.

*/
-- CreateEnum
CREATE TYPE "UPDATE_STATUS" AS ENUM ('IN_PROGRESS', 'SHIPPED', 'DEPRECATED');

-- DropForeignKey
ALTER TABLE "UpdatePoint" DROP CONSTRAINT "UpdatePoint_updatedId_fkey";

-- AlterTable
ALTER TABLE "Product" ALTER COLUMN "name" SET DATA TYPE VARCHAR(255);

-- AlterTable
ALTER TABLE "Update" DROP COLUMN "status",
ADD COLUMN     "status" "UPDATE_STATUS" NOT NULL DEFAULT 'IN_PROGRESS';

-- AlterTable
ALTER TABLE "UpdatePoint" DROP COLUMN "updatedId",
ADD COLUMN     "updateId" TEXT NOT NULL;

-- DropEnum
DROP TYPE "UPDATE_STATUSES";

-- AddForeignKey
ALTER TABLE "UpdatePoint" ADD CONSTRAINT "UpdatePoint_updateId_fkey" FOREIGN KEY ("updateId") REFERENCES "Update"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
