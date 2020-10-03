<?php
namespace Piwik\Plugins\AdminCommands\Commands;
/**
 * Piwik - free/libre analytics platform
 *
 * @link http://piwik.org
 * @license http://www.gnu.org/licenses/gpl-3.0.html GPL v3 or later
 */

use Piwik\Access;
use Piwik\Common;
use Piwik\Plugin\ConsoleCommand;
use Piwik\Plugins\SitesManager\API as APISitesManager;
use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Input\InputOption;
use Symfony\Component\Console\Output\OutputInterface;

/**
 * Command to selectively delete visits.
 */
class CreateSite extends ConsoleCommand
{
    protected function configure()
    {
        $this->setName('admin:create-site');
        $this->setDescription('Create a site this instance of matomo');
        $this->addOption('name', null, InputOption::VALUE_REQUIRED,
            'Name of the site');
        $this->addOption('url', null, InputOption::VALUE_REQUIRED,
            'URL to the website');
        $this->addOption('ecommerce', null, InputOption::VALUE_NONE | InputOption::VALUE_OPTIONAL,
            'If the site is an ecommerce website');
    }

    protected function execute(InputInterface $input, OutputInterface $output)
    {
        $name = $input->getOption('name');
        $url = $input->getOption('url');
        $ecommerce = $input->getOption('ecommerce');

        try {
            $result = Access::doAsSuperUser(function () use ($name, $url, $ecommerce) {
                return APISitesManager::getInstance()->addSite($name, $url, $ecommerce);
            });
        } catch (\Exception $ex) {
            $output->writeln("");

            throw $ex;
        }

        $this->writeSuccessMessage($output, array("Successfully created site " . $name . " (" . $url . ")"));
        $this->writeSuccessMessage($output, array("Think to add " . $url . " hostname to trusted hosts."));
    }
}
