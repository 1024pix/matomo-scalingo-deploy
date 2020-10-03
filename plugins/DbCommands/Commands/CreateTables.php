<?php
namespace Piwik\Plugins\DbCommands\Commands;
/**
 * Piwik - free/libre analytics platform
 *
 * @link http://piwik.org
 * @license http://www.gnu.org/licenses/gpl-3.0.html GPL v3 or later
 */

use Piwik\Common;
use Piwik\DbHelper;
use Piwik\Plugin\ConsoleCommand;
use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Input\InputOption;
use Symfony\Component\Console\Output\OutputInterface;

/**
 * Command to selectively delete visits.
 */
class CreateTables extends ConsoleCommand
{
    protected function configure()
    {
        $this->setName('database:create-tables');
        $this->setDescription('Create all database tables');
    }

    protected function execute(InputInterface $input, OutputInterface $output)
    {
        try {
            DbHelper::createTables();
        } catch (\Exception $ex) {
            $output->writeln("");

            throw $ex;
        }

        $this->writeSuccessMessage($output, array("Successfully created tables"));
    }
}
