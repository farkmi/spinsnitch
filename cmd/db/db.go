package db

import (
	"github.com/farkmi/spinsnitch-server/internal/util/command"
	"github.com/spf13/cobra"
)

func New() *cobra.Command {
	return command.NewSubcommandGroup("db",
		newMigrate(),
		newSeed(),
	)
}
