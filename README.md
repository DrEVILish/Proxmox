<h1 align="center">Proxmox VE Helper-Scripts</h1>
These scripts empower users to create a Linux container or virtual machine interactively, providing choices for both simple and advanced configurations. The basic setup adheres to default settings, while the advanced setup gives users the ability to customize these defaults. 
Options are displayed to users in a dialog box format. Once the user makes their selections, the script collects and validates their input to generate the final configuration for the container or virtual machine.
<p align="center">
Be cautious and thoroughly evaluate scripts and automation tasks obtained from external sources. <a href="https://github.com/DrEVILish/Proxmox/blob/main/CODE-AUDIT.md">Read more</a>
</p>

##
    bash -c "$(curl -fsSL https://raw.githubusercontent.com/drevilish/proxmox/main/ct/[container-name].sh)"

<p align="center">
This is a fork of ttecks original work before the community changes, with minor updates and additions.
</p>
<sub><div align="center"> Proxmox® is a registered trademark of Proxmox Server Solutions GmbH. </div></sub>
