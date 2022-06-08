import { PrismaService } from './prisma/prisma.service';
import { Controller, Get, Param, Post, Body, Put, Delete, Query } from '@nestjs/common';
import { AppService } from './app.service';
import { User as UserModel, Post as PostModel, Prisma } from '@prisma/client';

@Controller()
export class AppController {
  constructor(
    private readonly appService: AppService,
    private readonly prismaService: PrismaService,
  ) {}

  
}
