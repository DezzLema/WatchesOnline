import { Router } from 'express';
import authRoutes from './auth.routes';
import productRoutes from './products.routes';
import orderRoutes from './orders.routes';
import categoryRoutes from './category.routes';
import brandRoutes from './brand.routes';

const router = Router();

router.use('/auth', authRoutes);
router.use('/products', productRoutes);
router.use('/orders', orderRoutes);
router.use('/categories', categoryRoutes);
router.use('/brands', brandRoutes);

export default router;