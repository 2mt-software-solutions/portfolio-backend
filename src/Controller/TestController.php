<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Response;

class TestController extends AbstractController
{
    public function indexAction(): Response
    {
        $test = 'test that, for example xdebug & breakpoints work';

        return new JsonResponse($test, 200);
    }
}
