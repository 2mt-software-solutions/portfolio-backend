<?php

namespace App\Command;

use Symfony\Component\Console\Command\Command;
use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Output\OutputInterface;
use Symfony\Component\Console\Style\SymfonyStyle;
use Symfony\Component\DependencyInjection\ContainerInterface;

class TestCommand extends Command
{
    protected static $defaultName = 'portfolio:test';
    protected static $defaultDescription = 'Just for getting local setups with xdebug & co working';

    private ContainerInterface $container;

    protected function configure(): void
    {
        $this
            ->setDescription(self::$defaultDescription);
    }

    protected function execute(InputInterface $input, OutputInterface $output): int
    {
        $console = new SymfonyStyle($input, $output);
        $console->success('it works!');

        return Command::SUCCESS;
    }
}
