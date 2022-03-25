using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class AudioSourceManager : MonoBehaviour
{
    // SE用のAudioSource
    public AudioSource audioSe;
    
    void Awake()
    {
        DontDestroyOnLoad(this);
        audioSe = GetComponent<AudioSource>();
    }


    // 現在再生中のSEを止めて、新しく指定したAudioClipをSEとして再生する
    public void playSe(AudioClip audioCl) {
        if (audioSe.isPlaying) {
            audioSe.Stop();
        }
        audioSe.clip = audioCl;
        audioSe.Play();
    }


}
