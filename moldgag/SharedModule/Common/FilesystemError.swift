//
//  FilesystemError.swift
//  moldgag
//
//  Created by Adrian Tabirta on 26.06.2022.
//

public enum FilesystemError: Error {
   
    case fileCannotBeExported
    
    case cannotComposeAudioFileOnExport
    
    case cannotComposeVideoFileOnExport
    
    case cannotCreateExportSession
    
    case cannotCreateLocalUrl
    
    case exporter(Error)
}
