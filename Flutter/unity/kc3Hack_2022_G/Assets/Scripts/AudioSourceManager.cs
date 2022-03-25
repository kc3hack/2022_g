using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class AudioSourceManager : MonoBehaviour
{
    public AudioSource audioSe;
    
    void Awake()
    {
        DontDestroyOnLoad(this);
        audioSe = GetComponent<AudioSource>();
    }


    public void playSe(AudioClip audioCl) {
        if (audioSe.isPlaying) {
            audioSe.Stop();
        }
        audioSe.clip = audioCl;
        audioSe.Play();
    }


}
