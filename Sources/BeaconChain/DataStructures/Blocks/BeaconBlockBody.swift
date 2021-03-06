import Foundation

struct BeaconBlockBody {
    let proposerSlashings: [ProposerSlashing]
    let attesterSlashings: [AttesterSlashing]
    let attestations: [Attestation]
    let deposits: [Deposit]
    let voluntaryExits: [VoluntaryExit]
    let transfers: [Transfer]
}
