#!/bin/bash
ls -l /data/backup/* | grep tower- | sed "s/.$//"