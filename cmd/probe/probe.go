package probe

import (
	"github.com/farkmi/spinsnitch-server/internal/util/command"
	"github.com/spf13/cobra"
)

const (
	verboseFlag string = "verbose"
)

func New() *cobra.Command {
	return command.NewSubcommandGroup("probe",
		newLiveness(),
		newReadiness(),
	)
}
